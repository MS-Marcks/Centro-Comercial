var firebaseConfig = {
    apiKey: "AIzaSyDBuDTXG7uvJ8H8pdyr1a17TicYARdPENI",
    authDomain: "centro-comercial-617c3.firebaseapp.com",
    databaseURL: "https://centro-comercial-617c3.firebaseio.com",
    projectId: "centro-comercial-617c3",
    storageBucket: "centro-comercial-617c3.appspot.com",
    messagingSenderId: "985241840863",
    appId: "1:985241840863:web:573ccb0d25faeace074d6a"
};

firebase.initializeApp(firebaseConfig);

firebase.database().ref("estacionamiento").on("value", (data) => {
    let cont = 0;
    $("#estacionamiento tr").remove();
    data.forEach(e => {
        cont++;
        if (e.toJSON().ocupado === 1) {
            $("#estacionamiento").append(`
                <tr>
            <th scope="row">${cont}</th>
            <td>Estacionamiento ${cont}</td>
            <td>OCUPADO</td>
            </tr>`);
        }else{
            $("#estacionamiento").append(`
                <tr>
            <th scope="row">${cont}</th>
            <td>Estacionamiento ${cont}</td>
            <td>VACIO</td>
            </tr>`);
        }

        console.log(e.toJSON())
    });

})


firebase.database().ref("tiendas").on("value", (data) => {
    let cont = 0;
    $("#temperatura tr").remove();
    data.forEach(e => {
        cont++;
    
            $("#temperatura").append(`
                <tr>
            <th scope="row">${cont}</th>
            <td>Tienda ${cont}</td>
            <td>${e.toJSON().hum}</td>
            <td>${e.toJSON().temp}</td>
            </tr>`);
        

        console.log(e.toJSON())
    });

})


firebase.database().ref("usuario").on("value", (data) => {
    let cont = 0;
    $("#usuario tr").remove();
    data.forEach(e => {
    
        e.forEach(ei => {
            cont++;
            if(ei.toJSON().estado === "1"){
                $("#usuario").append(`
                <tr>
            <th scope="row">${ei.toJSON().uuid}</th>
            <td>${ei.toJSON().nombre}</td>
            <td>${ei.toJSON().apellido}</td>
            <td>${ei.toJSON().hora}</td>
            <td>INGRESO</td>
            <td>${ei.toJSON().descripcion}</td>
            </tr>`);
            }else  if(ei.toJSON().estado === "2"){
                $("#usuario").append(`
                <tr>
            <th scope="row">${ei.toJSON().uuid}</th>
            <td>${ei.toJSON().nombre}</td>
            <td>${ei.toJSON().apellido}</td>
            <td>${ei.toJSON().hora}</td>
            <td>REGRESO</td>
            <td>${ei.toJSON().descripcion}</td>
            </tr>`);
            }else{
                if(ei.toJSON().estado === "3"){
                    $("#usuario").append(`
                    <tr>
                <th scope="row">${ei.toJSON().uuid}</th>
                <td>${ei.toJSON().nombre}</td>
                <td>${ei.toJSON().apellido}</td>
                <td>${ei.toJSON().hora}</td>
                <td>SALIDA</td>
                <td>${ei.toJSON().descripcion}</td>
                </tr>`);
                }
            }
               
            
    
            console.log(ei.toJSON())
        });
          
    });

})