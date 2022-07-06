// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "@hotwired/turbo-rails"

// debugger

import "controllers"
////////////////////////////////////
import {build_catalog} from "./build_categories"
import {build_table}   from "./build_table"

import $ from "jQuery"




////////////////////////////////////
/////// получение данных

async function get_data() {
    const response_categories   = await fetch('/get_all_categories');
    const categories            = await response_categories.json()  
    return categories
}
const data = await get_data()
const [first_level_elements, second_level_elements, third_level_elements, categories] = data
//////////////////
////////////////////////////////////




// .replace(/\s+/g, '');

///////////////////////////////////
////////// каталог
let target_element = {}
let clicked_level = ''


$(".categories_for_materials").on('click', (el)=>{
    const target_name = el.target.innerHTML
   
    
    if ((target_name.length < 100) && (!el.target.classList.contains('add_category'))) {
/////////////////////////////////////////////////////////////////////////////////////////////////     
        sessionStorage.current_category = el.target.innerHTML
//  определение кликнутого элемента и его уровня 
        
        first_level_elements.forEach(el=> {
            if (el.name == target_name) {
                target_element = el
                clicked_level = 'level1'
            }
        })

        second_level_elements.forEach(el=> {
            if (el.name == target_name) {
                target_element = el
                clicked_level = 'level2'
            }
        })

        third_level_elements.forEach(el=> {
            if (el.name == target_name) {
                target_element = el
                clicked_level = 'level3'
            }
        })


/////////////////////////////////////////////////////////////////////////
        const id_s1 = []
        const id_s2 = []
        const id_s3 = []
        const not_id_s = []

        if (clicked_level == 'level1') {
            id_s1.push(target_element.id)
        
            second_level_elements.forEach(el=>{
                if (el.parent_id == target_element.id) id_s2.push(el.id)
            })
        
            third_level_elements.forEach(el=>{
                if (id_s2.includes(el.parent_id)) id_s3.push(el.id)
            })
        }

        if (clicked_level == 'level2') {
            id_s2.push(target_element.id)

            third_level_elements.forEach(el=>{
                if (el.parent_id == target_element.id) id_s3.push(el.id)
            })
        }

        if (clicked_level == "level3") {
            id_s3.push(target_element.id)
        }

        const sum_id_s = id_s1.concat(id_s2, id_s3)
        categories.forEach(el=> {
            if (!sum_id_s.includes(el.id))  not_id_s.push(el.id)
        })
///////////////////////////////////////////

        build_catalog(first_level_elements, second_level_elements, third_level_elements, target_element)
        build_table(not_id_s)
    }
}) 

let flag_catalog = true
const cur_url = window.location.href
const sub_urls = ["admins", "sellers", "users", "custumers", "sign_out_reg", "in_seller_cabinet_from_admin", "mod"]
sub_urls.forEach(sub_url=>{ if (cur_url.includes(sub_url)) flag_catalog = false})


if (sessionStorage.clicked_button_with_category == "true") {
    build_catalog(first_level_elements, second_level_elements, third_level_elements, sessionStorage.current_category)
} else if (flag_catalog) {

    build_catalog(first_level_elements, second_level_elements, third_level_elements)
}
////////////////////////////////////////////////////
if ((!window.location.href.includes("sellers")) && (!window.location.href.includes("sign_out_reg")) &&  (!window.location.href.includes("sign_out_reg")) && (!window.location.href.includes("in_seller_cabinet_from_admin")) && (!window.location.href.includes("mod"))) build_table()

















$("#logo").on('click', ()=> window.location.href = "/")
$("#title_caterory").on('click', ()=>{
    build_catalog(first_level_elements, second_level_elements, third_level_elements)
    build_table()
})
    
if (document.querySelector("#title_caterory")) {
    
    $("#add_material2").removeClass("none")
    $("#add_material2").on('click', ()=> {
        window.location.href = ' /c_items/new'
        sessionStorage.clicked_button_with_category = "true"
    })
}



$('#but_history').on("click", ()=>window.location.href = "/a3_custumers/history")
$('#but_basket').on("click", ()=>window.location.href = "/a3_custumers/main")



$("#submit_clean").on("click", (sub)=>{
    setTimeout(() => {
        const checked_checkboxes = document.querySelectorAll("input[type=checkbox]:checked")
        checked_checkboxes.forEach((el)=>{el.parentNode.parentNode.remove()})
    }, 0); 
})

$("#submit_form").on("click", ()=>{
    setTimeout(() => {
        const checked_checkboxes = document.querySelectorAll("input[type=checkbox]:checked")
        checked_checkboxes.forEach((el)=>{el.parentNode.parentNode.remove()})
    }, 0); 
})


$("#form_material").on("click", (e)=>{
    if ($("#material_category_name").val() == 'выберите категорию') {
        alert("выбор категории обязателен")
        e.preventDefault()
    }
})

if (document.querySelector("#messages")) {
    document.querySelector("#messages").addEventListener("click", (e)=>{
        if (e.target.id != "krest_message") {
            $("#sub_message").removeClass('none')
        }
    })
}
 
$("#krest_message").on("click", ()=>$("#sub_message").addClass('none'))

$("#price_retail_checkbox").on("change", ()=> $("#price_retail_div").toggleClass("none"))
$("#price_wholesale_checkbox").on("change", ()=> $("#price_wholesale_div").toggleClass("none"))


// создание сообщения
if (document.querySelectorAll(".but_sent_mes").length != 0) {
    const buttons_sent_mes = document.querySelectorAll(".but_sent_mes")
    buttons_sent_mes.forEach(but=>{
        but.addEventListener("click", ()=>{
            if (but.nextSibling.value.length != 0) {
                const body = but.nextSibling.value


                const to_user_id = but.nextSibling.dataset.userid
                let from_user_id = ''
                if (to_user_id == "Покупатель") {
                    from_user_id = "Покупатель"
                } else if (to_user_id == "Продавец") {
                    from_user_id = "Продавец"
                } else {
                    from_user_id = document.querySelector("#user_id").innerHTML
                }



                // const from_user_id = (to_user_id == "Покупатель") ?  "Покупатель" : document.querySelector("#user_id").innerHTML
                fetch(`/admins/create/mes/${to_user_id}/${from_user_id}/${body}`)
                but.nextSibling.value = ""
                alert("сообщение отправлено")
            }
        })
    })  
}

if (document.querySelector("#user_id")) {
    const current_user_id = document.querySelector("#user_id").innerHTML 
    const buttons_moderating = document.querySelectorAll(".but_moderating")
    buttons_moderating.forEach((but)=>{
        but.addEventListener("click", (el)=>{
            const material_id = el.target.dataset.toactive
            el.target.parentNode.parentNode.remove()
            fetch(`/mod/material/to/active/${material_id}/${current_user_id}`)
        })
    })
}

const buttuns_edit_mat = document.querySelectorAll(".but_edit_mat")
buttuns_edit_mat.forEach((but)=>{
    but.addEventListener("click", ()=>{
        fetch(`/moderating/material/edit/${material_id}/${current_user_id}`)
    })
})

const buttons_delete_mat = document.querySelectorAll(".but_delete_mat") 
buttons_delete_mat.forEach((but)=>{
    but.addEventListener("click", (el)=>{
        const current_user_id = el.target.dataset.cur_userid
        const material_id = el.target.dataset.todelete
        console.log(material_id)
        console.log(current_user_id)
        el.target.parentNode.parentNode.remove()
        fetch(`/mod/material/to/delete/${material_id}/${current_user_id}`)

    })
})





// поисковик продавцов, покупателей, модераторов из кабинета админа
const input_users = document.querySelector("#input_users")
const trs = document.querySelectorAll(".tr")
const tds = document.querySelectorAll(".td_company")
if (input_users) {
    input_users.addEventListener("keyup", (up)=>{
        if (up.key == "Enter") {
           const search_value = input_users.value
           trs.forEach(element => {element.classList.add("none")});
           tds.forEach(element =>{
               if (element.innerHTML.includes(search_value)) element.parentNode.classList.remove("none")
        
           })
        }
    })
    input_users.onchange = (e) => {
        const search_value = e.target.value
           trs.forEach(element => {element.classList.add("none")});
           tds.forEach(element =>{
               if (element.innerHTML.includes(search_value)) element.parentNode.classList.remove("none")
           })
    }
    const krest_custumers = document.querySelector("#krest_users")
    krest_custumers.addEventListener("click", ()=>{
        trs.forEach(element => {element.classList.remove("none")});
        input_users.value = ''
    })
}



setTimeout(() => {
    try {
        fetch("/update_purse")
     }
     catch  { 
       console.log(" fetch('/update_purse')    ERROR")   // не стандартно
     }
}, 5000);



