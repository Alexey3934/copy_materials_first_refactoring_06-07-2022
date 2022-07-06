import $ from "jQuery"

async function get_data_for_table() {
    const response_materials    = await fetch('/get_all_materials');
    const materials             = await response_materials.json()  
    return materials
}
const materials = await get_data_for_table()




const cloned_data_all = () =>JSON.parse(JSON.stringify(materials))

let not_id_s = []
let current_region = ''
let current_sort_input = ''



////////////////////////////////////////////////////

///////////////////////////////////////////////////
const build_table = (raw) => { 

    const region = $("#region")
    region.on('change', ()=>{
        current_region = region.val()
        build(cloned_data(not_id_s))
    })
    current_region = region.val()
    
    const sort_input = $("#sort_input")
    sort_input.on('change', ()=>{
        current_sort_input = sort_input.val()
        build(cloned_data(not_id_s))
    })
    current_sort_input = sort_input.val()
    $("#krest").on("click", ()=> window.location.href = '/')

    


    not_id_s = raw
    $('.sort').removeClass('active')
    $("#but_name_to_down").addClass('active')

    const cloned_data = (not_id_s) => {
    

            
        let result = []
        const raw = cloned_data_all()
    
        if (not_id_s) {
            raw.forEach(el=> {
                if (!not_id_s.includes(el.category_id)) result.push(el)
            })
        } else result = raw

        return result
    }
//////////////////////////////////////////////////
const delete_table = () => {
    const tr_nodes = document.querySelectorAll(".table tr")
    const [first, ...rows] = tr_nodes
    rows.forEach(el=>el.remove())
}   


// создание таблицы
const build = (data_raw) =>{
    if (!window.location.href.includes("custumers")) delete_table()
    let data = data_raw.filter((el)=>el.place == current_region);
    if (current_sort_input != '') data = data.filter(el=>el.description == current_sort_input)
// console.log(data_raw)
    const table = document.querySelector('.table')

    
    if (table) {

// для покупателя в корзине 
    // // const current_user_id = $("#user_id").text()
    // $(".delete_from_basket").on("click", (but)=>{

    //     const mat_id_to_delete = but.target.getAttribute("data-mat_id")
    //     const current_user_id = but.target.getAttribute("data-user_id")
    //     fetch(`/baskets/delete/${current_user_id}/${mat_id_to_delete}`)
    //     //удаление стороки
    //     but.target.parentElement.parentElement.remove()
    // })

////////////////////////
        for (const row of data) {
            if (row.active) {
               const trEl = document.createElement('tr')
// для покупателя 
               if (($("#workgroupe").text() == "Покупатель") && (!window.location.href.includes('custumer'))) {
                
                   const button = document.createElement('button')
                   button.innerHTML = 'корзина'


                   if ($("#basket_ids")){ 
                    console.log($("#basket_ids").text())
                        const basket_ids = JSON.parse($("#basket_ids").text())
                        if (basket_ids.includes(row.id)) button.classList.add("active")
                    }
                   trEl.append(button)

                   button.addEventListener("click", ()=> {
                      button.classList.add("active")
                      const current_user_id = $("#user_id").text()
                      const clicked_material_id = row.id
                    //   console.log("clicked_material_id = ", clicked_material_id)
                        fetch(`/requests/add/${current_user_id}/${clicked_material_id}`)
                   })
                }
///////////////////////

                const price_retail = (row.price_retail == 0) ? " -" : row.price_retail
                const price_wholesale = (row.price_wholesale == 0) ? " -" : row.price_wholesale
                const amount_wholesale = (row.amount_wholesale == 0) ? " -" : row.amount_wholesale


                const data_fields = [row.description,
                                    row.unit,
                                    price_retail,
                                    price_wholesale,
                                    amount_wholesale,
                                    row.company,
                                    row.phone]
                  
                for (const field of data_fields) {
                    const cell = document.createElement("td");
                    const cellText = document.createTextNode(field)
                    cell.appendChild(cellText)
                    cell.classList.add('td')
                    trEl.appendChild(cell);
                }
                table.appendChild(trEl)

            }
        }
    }
} 
build(cloned_data(not_id_s))

///////////////////////////////////////////////////////////////////////////////////////////////////////////
    const sorting = (arr, kind) => {
        const result = [];
        let currentGroup = [];
        arr.forEach(e => {
                if (currentGroup.length == 0) {
                        currentGroup.push(e);
                } else if (currentGroup[0].description === e.description) {
                        currentGroup.push(e);
                } else {
                        result.push(currentGroup);
                        currentGroup = [e];
                }
        });
        if (currentGroup.length !== 0) {
                result.push(currentGroup);
        }
        switch (kind) {
            case 'price_retail_to_up':
                result.forEach(arr=> arr.sort((a,b)=>b.price_retail - a.price_retail))
                break;
            case 'price_retail_to_down':
                result.forEach(arr=> arr.sort((a,b)=>a.price_retail - b.price_retail))        
            break;
            case 'price_wholesale_to_up':
                result.forEach(arr=> arr.sort((a,b)=>b.price_wholesale - a.price_wholesale))
                break;
            case 'price_wholesale_to_down':
                result.forEach(arr=> arr.sort((a,b)=>a.price_wholesale - b.price_wholesale))        
            break;
        }




        return result.flat();
    }
///////////////////////////////////////////////////////////////////////////////////////////////////////////
    const click_name_to_down = () => {
        if (!$("#but_name_to_down").hasClass('active')) {
            $('.sort').removeClass('active')
            $("#but_name_to_down").addClass('active')
            build(cloned_data(not_id_s))
        }
    }
 
    const click_name_but_up = () => {
        if (!$("#but_name_to_up").hasClass('active')) {
            // delete_table()
            $('.sort').removeClass('active')
            $("#but_name_to_up").addClass('active')  
            build(cloned_data(not_id_s).reverse())
        }
    }
 
    const click_price_retail_to_up = () => {
        if (!$("#but_price_retail_to_up").hasClass('active')) {
            // delete_table()

            if ($("#but_name_to_up").hasClass('active')){
                $('.sort').removeClass('active')
                $("#but_name_to_up").addClass('active')
                $("#but_price_retail_to_up").addClass('active')

                const sorted = sorting(cloned_data(not_id_s).reverse(), 'price_retail_to_up')
                build(sorted.flat())
            }
            if ($("#but_name_to_down").hasClass('active')){
                $('.sort').removeClass('active')
                $("#but_name_to_down").addClass('active')
                $("#but_price_retail_to_up").addClass('active')
                
                const sorted = sorting(cloned_data(not_id_s), 'price_retail_to_up')
                build(sorted.flat())
            }
        } 
    }

    const click_price_retail_to_down = () => {
        if (!$("#but_price_retail_to_down").hasClass('active')) {
            // delete_table()

            if ($("#but_name_to_up").hasClass('active')){
                $('.sort').removeClass('active')
                $("#but_name_to_up").addClass('active')
                $("#but_price_retail_to_down").addClass('active')

                const sorted = sorting(cloned_data(not_id_s).reverse(), 'price_retail_to_down')
                build(sorted.flat())
            }
            if ($("#but_name_to_down").hasClass('active')){
                $('.sort').removeClass('active')
                $("#but_name_to_down").addClass('active')
                $("#but_price_retail_to_down").addClass('active')

                const sorted = sorting(cloned_data(not_id_s), 'price_retail_to_down')
                build(sorted.flat())
            }
        } 
    }

    const click_price_wholesale_to_up = () => {
        if (!$("#but_price_wholesale_to_up").hasClass('active')) {
            // delete_table()

            if ($("#but_name_to_up").hasClass('active')){
                $('.sort').removeClass('active')
                $("#but_name_to_up").addClass('active')
                $("#but_price_wholesale_to_up").addClass('active')
                
                const sorted = sorting(cloned_data(not_id_s).reverse(), 'price_wholesale_to_up')
                build(sorted.flat())
            }
            if ($("#but_name_to_down").hasClass('active')){
                $('.sort').removeClass('active')
                $("#but_name_to_down").addClass('active')
                $("#but_price_wholesale_to_up").addClass('active')
                
                const sorted = sorting(cloned_data(not_id_s), 'price_wholesale_to_up')
                build(sorted.flat())
            }
        } 

    }

    const click_price_wholesale_to_down = () => {
        if (!$("#but_price_wholesale_to_down").hasClass('active')) {
            // delete_table()

            if ($("#but_name_to_up").hasClass('active')){
                $('.sort').removeClass('active')
                $("#but_name_to_up").addClass('active')
                $("#but_price_wholesale_to_down").addClass('active')
            
                const sorted = sorting(cloned_data(not_id_s).reverse(), 'price_wholesale_to_down')
                build(sorted.flat())
            }
            if ($("#but_name_to_down").hasClass('active')){
                $('.sort').removeClass('active')
                $("#but_name_to_down").addClass('active')
                $("#but_price_wholesale_to_down").addClass('active')
    
                const sorted = sorting(cloned_data(not_id_s), 'price_wholesale_to_down')
                build(sorted.flat())
            }
        } 
    }


    const arrow_up = '<svg width="11" height="11" viewBox="0 0 11 11" xmlns="http://www.w3.org/2000/svg"><line x1="6" y1="11" x2="6" y2="0" stroke="black"/><line x1="0" y1="5" x2="6" y2="0" stroke="black"/><line x1="11" y1="5" x2="6" y2="0" stroke="black"/></svg>'
    const arrow_down = '<svg width="11" height="11" viewBox="0 0 11 11" xmlns="http://www.w3.org/2000/svg"><line x1="6" y1="11" x2="6" y2="0" stroke="black"/><line x1="0" y1="6" x2="6" y2="11" stroke="black"/><line x1="11" y1="6" x2="6" y2="11" stroke="black"/></svg>'

    $("#but_name_to_up").on('click', click_name_but_up)
    $("#but_name_to_up").html(arrow_up) 
    $("#but_name_to_down").on('click', click_name_to_down)
    $("#but_name_to_down").html(arrow_down)
    $("#but_name_to_down").addClass('active')

    $("#but_price_retail_to_up").on('click', click_price_retail_to_up)
    $("#but_price_retail_to_up").html(arrow_up)
    $("#but_price_retail_to_down").on('click', click_price_retail_to_down)
    $("#but_price_retail_to_down").html(arrow_down)
    
    $("#but_price_wholesale_to_up").on('click', click_price_wholesale_to_up)
    $("#but_price_wholesale_to_up").html(arrow_up)
    $("#but_price_wholesale_to_down").on('click', click_price_wholesale_to_down)
    $("#but_price_wholesale_to_down").html(arrow_down)

}

const material_descriptions = []
materials.forEach(mat=>{if (!material_descriptions.includes(mat.description)) material_descriptions.push(mat.description)})
material_descriptions.forEach(des=>{
    const option = document.createElement("option")
    option.setAttribute("value", `${des}`)
    $("#list").append(option)
})

    


export {build_table}