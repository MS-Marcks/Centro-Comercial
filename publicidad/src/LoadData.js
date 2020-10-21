import React, { Component } from 'react';
import AsyncStorage from '@react-native-community/async-storage'
import {
    Alert
} from 'react-native';
export const CargarIbeacoins = async () => {
    return fetch('http://apicomercial.pvivirtual.com/api/cliente/ibeacoins', {
        method: 'GET',
        header: {
            'Accept': 'application/json',
            'Content-type': 'application/json; charset=utf8'
        }
    }).then((response) => response.json())
        .then((responsejson) => {
            return responsejson;
        }).catch((err) => {
            //Alert.alert('Error', err.message);
        });
}

export const CargarProductos = async () => {
    const id = await AsyncStorage.getItem('id_cliente')
    return fetch(`http://apicomercial.pvivirtual.com/api/cliente/producto/${id}`, {
        method: 'GET',
        header: {
            'Accept': 'application/json',
            'Content-type': 'application/json; charset=utf8',
        }
    }).then((response) => response.json())
        .then((responsejson) => {
            return responsejson;
        }).catch((err) => {
            Alert.alert('Error', err.message);
        });
}
export const CargarTipo = () => {
    return fetch(`http://apicomercial.pvivirtual.com/api/cliente/tipo`, {
        method: 'GET',
        header: {
            'Accept': 'application/json',
            'Content-type': 'application/json; charset=utf8',
        }
    }).then((response) => response.json())
        .then((responsejson) => {
            return responsejson;
        }).catch((err) => {
            Alert.alert('Error', err.message);
        });
}
