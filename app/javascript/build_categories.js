import $ from "jQuery"
const category_name = document.querySelector("#material_category_name")
let counter_ids = 0

let target_element_level1_for_new_element = {}
let target_element_level2_for_new_element = {}


const build_catalog = (first_level_elements, second_level_elements, third_level_elements, target_element = null, ) => {
   
    if (target_element) $("#hidden_input4").val(target_element.name)
    // if ( sessionStorage.clicked_button_with_category == 'true')  
// debugger

    const div_catalog_for_materials = document.querySelector(".categories_for_materials")
    while (div_catalog_for_materials.firstChild) div_catalog_for_materials.removeChild(div_catalog_for_materials.firstChild);

// счетчик для создание новых категорий, для временных ids только в js чтоб не было одинаковых ids
    const ids = []
    first_level_elements.forEach(el=>ids.push(el.id))
    second_level_elements.forEach(el=>ids.push(el.id))
    third_level_elements.forEach(el=>ids.push(el.id))
    ids.forEach(id=>{if (id > counter_ids) counter_ids = id})
//////////////////////////////////////////////////////////////////

    const build_button_add = (current_level) => {
        const div = document.createElement("div")
        div.classList.add(`${current_level}`)
        if (!category_name) div.classList.add("none")
        
        const button = document.createElement("button")
        button.innerHTML= "Добавить категорию"
        button.classList.add("add_category")
        button.id = current_level + "_button"

        const input = document.createElement("input")
        input.classList.add("add_category")
        input.id = current_level + '_input'

        div.appendChild(input)
        div.appendChild(button)

        return div      
    }
    
    const clicked_first_level = (target_name) => {
       $("#hidden_input1").val(target_name)
        $("#material_category_name").val(target_name)
        let target_element = {}
        first_level_elements.forEach((el)=>{if (el.name == target_name) target_element = el})
        target_element_level1_for_new_element = target_element


        first_level_elements.forEach(el=>{
            if (el.name != target_element.name){
                const p1 = document.createElement("p")
                p1.innerHTML = el.name
                p1.classList.add("level1", "border", "underline", "hover")
                div_catalog_for_materials.appendChild(p1)
            } else if (el.name == target_element.name) {
                const p1_active = document.createElement('p')
                p1_active.classList.add("level1", "bold", "border", "underline")
                p1_active.innerHTML = target_element.name
                div_catalog_for_materials.appendChild(p1_active)

                second_level_elements.forEach(el=>{
                    if (el.parent_id == target_element.id) {
                        const el_level2 = document.createElement("p")
                        el_level2.innerHTML = el.name
                        el_level2.classList.add("level2", "border", "underline", "hover")
                        div_catalog_for_materials.appendChild(el_level2)
                    }
                })
                div_catalog_for_materials.appendChild(build_button_add('level2'))
            }
        })
        div_catalog_for_materials.appendChild(build_button_add('level1'))
    creationg_new_category()
    }
    
    const clicked_second_level = (target_name) => {
        $("#hidden_input2").val(target_name)
        $("#material_category_name").val(target_name)
        let target_element = {}
        second_level_elements.forEach((el)=>{if (el.name == target_name) target_element = el})
        target_element_level2_for_new_element = target_element

        first_level_elements.forEach(el=>{
            if (el.id != target_element.parent_id){
                const p1 = document.createElement("p")
                p1.innerHTML = el.name
                p1.classList.add("level1", "border", "underline", "hover")
                div_catalog_for_materials.appendChild(p1)
            } else if (el.id == target_element.parent_id) {
                const p1_active = document.createElement('p')
                p1_active.classList.add("level1", "border", "underline", "hover")
                p1_active.innerHTML = el.name
                div_catalog_for_materials.appendChild(p1_active)

                second_level_elements.forEach(el=>{
                    if ((el.id != target_element.id) && (el.parent_id == target_element.parent_id))  {
                        const p2 = document.createElement("p")
                        p2.innerHTML = el.name
                        p2.classList.add("level2", "border", "underline", "hover")
                        div_catalog_for_materials.appendChild(p2)
                    } else if ((el.id == target_element.id) && (el.parent_id == target_element.parent_id)) {
                        const p2 = document.createElement("p")
                        p2.innerHTML = el.name
                        p2.classList.add("level2", "border", "underline", "bold")
                        div_catalog_for_materials.appendChild(p2)
                    
                        third_level_elements.forEach(el=>{
                            if (target_element.id == el.parent_id) {
                                const elP = document.createElement("p")
                                elP.classList.add("level3", "border", "underline", "hover")
                                elP.innerHTML = el.name
                                div_catalog_for_materials.appendChild(elP)
                            }
                        })
                        div_catalog_for_materials.appendChild(build_button_add('level3'))
                    }
                })
                div_catalog_for_materials.appendChild(build_button_add('level2'))
            }
        })
        div_catalog_for_materials.appendChild(build_button_add('level1'))
        creationg_new_category(target_element)
    }
    
    const clicked_third_level = (target_name) => {
        $("#hidden_input3").val(target_name)        
        $("#material_category_name").val(target_name)
        let target_element = {}
        third_level_elements.forEach((el)=>{if (el.name == target_name) target_element = el})
        
        // target_element_level3_for_new_element = target_name

        let active_element_level2_id = 0



        let active_element_level1_id = 0
        second_level_elements.forEach(el=>{
            if (target_element.parent_id == el.id) active_element_level1_id = el.parent_id
        })

        first_level_elements.forEach(el=>{
            if (el.id != active_element_level1_id){
                const p1 = document.createElement("p")
                p1.innerHTML = el.name
                p1.classList.add("level1", "border", "underline", "hover")
                div_catalog_for_materials.appendChild(p1)
            } else if (el.id == active_element_level1_id) {
                const p1_active = document.createElement('p')
                p1_active.classList.add("level1", "border", "underline", "hover")
                p1_active.innerHTML = el.name
                div_catalog_for_materials.appendChild(p1_active)

                second_level_elements.forEach(el=>{
                    if ((el.id != target_element.parent_id) && (el.parent_id == active_element_level1_id)) {
                        const p2 = document.createElement("p")
                        p2.innerHTML = el.name
                        p2.classList.add("level2", "border", "underline", "hover")
                        div_catalog_for_materials.appendChild(p2)
                    } else if ((el.id == target_element.parent_id) &&  (el.parent_id == active_element_level1_id)) {
                        active_element_level2_id = el.id
                        const p2 = document.createElement("p")
                        p2.innerHTML = el.name
                        p2.classList.add("level2", "border", "underline", "hover")
                        div_catalog_for_materials.appendChild(p2)
                    
                        third_level_elements.forEach(el=>{
                            if ((target_element.id != el.id) && (el.parent_id == active_element_level2_id)) {
                                const elP = document.createElement("p")
                                elP.classList.add("level3", "border", "underline", "hover")
                                elP.innerHTML = el.name
                                div_catalog_for_materials.appendChild(elP)
                            } else if ((target_element.id == el.id) && (el.parent_id == active_element_level2_id))  {
                                const elP = document.createElement("p")
                                elP.classList.add("level3", "border", "underline", "bold")
                                elP.innerHTML = el.name
                                div_catalog_for_materials.appendChild(elP)
                            }
                        })
                        div_catalog_for_materials.appendChild(build_button_add('level3'))
                    }
                })
                div_catalog_for_materials.appendChild(build_button_add('level2'))
            }
        })
        div_catalog_for_materials.appendChild(build_button_add('level1'))
        creationg_new_category()
    }
    
 


    const creationg_new_category = (target_element) => {
        $("#level1_button").on("click", ()=>{
            const input1_val_new_category = $("#level1_input").val()  
            if (input1_val_new_category != '') {
                counter_ids += 1
                const new_caterory_element = {id: counter_ids, name: input1_val_new_category, parent_id: null}

                first_level_elements.push(new_caterory_element)
                if (first_level_elements.length > 1) first_level_elements.sort((a, b) => a.name.toLowerCase() > b.name.toLowerCase() ? 1 : -1)
                build_catalog(first_level_elements,  second_level_elements, third_level_elements, new_caterory_element)
            }
        })
        $("#level2_button").on("click", ()=>{
            const input2_val_new_category = $("#level2_input").val()
            if (input2_val_new_category != '') {
                counter_ids += 1
                const new_caterory_element = {id: counter_ids, name: input2_val_new_category, parent_id: target_element_level1_for_new_element.id}

                second_level_elements.push(new_caterory_element)
                if (second_level_elements.length > 1) second_level_elements.sort((a, b) =>{a.name.toLowerCase() > b.name.toLowerCase() ? 1 : -1})
                build_catalog(first_level_elements,  second_level_elements, third_level_elements, new_caterory_element)
            }
        })
        $("#level3_button").on("click", ()=>{
            const input3_val_new_category = $("#level3_input").val()
            if (input3_val_new_category != '') {
                counter_ids += 1
                const new_caterory_element = {id: counter_ids, name: input3_val_new_category, parent_id: target_element_level2_for_new_element.id}

                third_level_elements.push(new_caterory_element)
// debugger
                if (third_level_elements.length > 1)  third_level_elements.sort((a, b) => a.name.toLowerCase() > b.name.toLowerCase() ? 1 : -1)
                build_catalog(first_level_elements,  second_level_elements, third_level_elements, new_caterory_element)
            }
        })
    }

// debugger
 
    if (target_element == null){
////////////////////////////////////////////////////////////
//////////// первичный список при открытии страницы
        $("#hidden_input1").val("nil")
        first_level_elements.forEach(element => {
            const pEL = document.createElement("p")
            pEL.innerHTML = element.name
            pEL.classList.add("level1" ,"border", "underline", "hover")
            div_catalog_for_materials.appendChild(pEL)
        });

        div_catalog_for_materials.appendChild(build_button_add("level1"))

        creationg_new_category()

    } else {
// удаление предидущего каталога
        while (div_catalog_for_materials.firstChild) div_catalog_for_materials.removeChild(div_catalog_for_materials.firstChild);
 
        let target_name = target_element.name
        if ( sessionStorage.clicked_button_with_category == 'true') {
            sessionStorage.clicked_button_with_category = 'false'
            target_name = sessionStorage.current_category
            $("#hidden_input4").val(target_element)
        }
        
        // if (window.location.href.includes("edit")) target_name = target_element

// определении кликнутого элемента в

        first_level_elements.forEach(el => {
            if (el.name == target_name) clicked_first_level(target_name)
        })
        second_level_elements.forEach(el => {
            if (el.name == target_name) clicked_second_level(target_name)            
        })
        third_level_elements.forEach(el =>  {
            if (el.name == target_name) clicked_third_level(target_name)  
        })
    }
}


export {build_catalog}