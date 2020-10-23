import { width, height, totalSize } from 'react-native-dimension';
import React, { Component } from 'react';
import AsyncStorage from '@react-native-community/async-storage'
import {
  PermissionsAndroid,
  Text,
  View,
  DeviceEventEmitter,
  ToastAndroid,
  AppState,
  Image,
  StyleSheet,
  Alert,
  TextInput,
  TouchableHighlight,
  Dimensions,
} from 'react-native';
import Icon from 'react-native-vector-icons/Ionicons';
import Beacons from 'react-native-beacons-manager';
import { CargarIbeacoins, CargarProductos, CargarTipo } from './src/LoadData'
var PushNotification = require('react-native-push-notification')

class App extends Component {
  constructor(props) {
    super(props);
    this.handleAppStateChange = this.handleAppStateChange.bind(this);
    this.state = {
      imagen1: [],
      texto1: "",
      Regiones: [],
      cargardatos: false,
      id: 0,
      user: "",
      pass: "",
      inicio: false
    }
  }
  componentDidMount = () => {

    AppState.addEventListener('change', this.handleAppStateChange);
    try {
      const granted = PermissionsAndroid.request(
        PermissionsAndroid.PERMISSIONS.ACCESS_FINE_LOCATION,
        {
          'title': 'Location Permission',
          'message': 'Activeev needs to access your location.'
        }
      )
      if (granted === PermissionsAndroid.RESULTS.GRANTED) {
        console.log("Location Permitted")
      } else {
        console.log("Location permission denied")
      }

    } catch (err) {
      console.warn(err)
    }
  }
  componentWillUnmount() {
    AppState.addEventListener('change', this.handleAppStateChange);
  }
  handleAppStateChange(AppState) {
    if (AppState === 'background') {
      { this.RastreoPasivo() }
    } else if (AppState === 'active') {
      this.RastreoActivo()
    }
  }
  funIniciarSesion() {
    let user = this.state.user;
    let pass = this.state.pass;
    Alert.alert(user, pass);
    if (user != "" && pass != "") {
      fetch(`https://www.apicomercial.pvivirtual.com/api/cliente/session/${user}/${pass}`, {
        method: 'POST',
        header: {
          'Accept': 'application/json',
          'Content-type': 'application/json',
        },
        body: JSON.stringify({
          usuario: user,
          pass: pass
        })
      }).then((response) => response.json())
        .then((responsejson) => {
          if (responsejson != null) {
            AsyncStorage.setItem("id_cliente", responsejson.id_cliente + '');
            ToastAndroid.show("Reinicie LA APLICACION PARA GUARDAR LOS CAMBIOS ", ToastAndroid.SHORT);
          } else {
            Alert.alert('ERROR', "DATOS INCORRECTOS");
          }

        }).catch((err) => {
          Alert.alert('Error', err.message);
        });
    } else {
      Alert.alert("ERROR", "DEBES DE COLOCAR TODOS LOS DATOS PARA INICIAR SESION");
    }


  }
  render() {
    if (this.state.inicio == false) {
      return (
        <View style={SInicio.contenendor}>
          <View style={SInicio.nav}>
            <View style={SInicio.CentradoTitulo}><Text style={SInicio.Titulo}>INICIAR SESION</Text></View>
          </View>

          <View style={SInicio.ContenedorInicio}>
          
            <TextInput style={SInicio.campos} placeholder="NIT" onChangeText={(user) => this.setState({ user })} value={this.state.user} />
            <TextInput style={SInicio.campos} secureTextEntry={true} placeholder="Contraseña" onChangeText={(pass) => this.setState({ pass })} value={this.state.pass} />
            <TouchableHighlight style={SInicio.btnIniciarSesion} onPress={() => { this.funIniciarSesion() }}>
              <Text style={SInicio.TituloBoton} >Iniciar Sesion</Text>
            </TouchableHighlight>
          </View>
        </View>
      )
    }
    if (this.state.imagen1 != null && this.state.texto1 != "") {
      return (
        <View style={SInicio.Contenedor}>
          <View style={SInicio.Cimagen}>{this.state.imagen1}</View>
          <View style={SInicio.Ctexto} ><Text style={SInicio.Texto}>{this.state.texto1}</Text></View>
        </View>
      )
    } else {
      return (
        <View style={SInicio.Contenedor}>
          <View style={SInicio.Cimagen}>{this.state.imagen2}</View>
          <View style={SInicio.Ctexto} ><Text style={SInicio.Texto}>{this.state.texto2}</Text></View>
        </View>
      )
    }
  }

  RastreoActivo() {
    AsyncStorage.getItem('id_cliente', (err, data) => {
      if (data !== null) {
        this.setState({ inicio: true })
        CargarIbeacoins().then(data => {
          var Regions = data;
          Beacons.detectIBeacons()
          try {
            for (let i = 0; i < Regions.length; i++) {
              Beacons.stopMonitoringForRegion(Regions[i]);
            }
            for (let i = 0; i < Regions.length; i++) {
              Beacons.startMonitoringForRegion(Regions[i]);
            }
            ToastAndroid.show("HAS HABILITADO EL RASTREO DE BEACOINS ", ToastAndroid.SHORT);
          } catch (err) {
            ToastAndroid.show('NO SE COMENZO EL MONITOREO DE REGIONES, ERROR: ${err}', ToastAndroid.LONG);
          }

          DeviceEventEmitter.addListener('regionDidEnter', (region) => {
            CargarProductos().then(productos => {
              CargarTipo().then(tipo => {
                for (let i = 0; i < tipo.length; i++) {
                  if (region.identifier == tipo[i].identifier && productos[0].id_tipo == tipo[i].id_tipo) {
                    let imagen = [];
                    imagen.push(<Image key={0} style={SInicio.imagen} source={{ uri: productos[0].imagen }}></Image>);
                    this.setState({ texto1: productos[0].descripcion })
                    this.setState({ imagen1: imagen })
                    break;
                  }
                }

              })
            })
            DeviceEventEmitter.addListener('regionDidExit', (region) => {
              let imagen = [];
              imagen.push(<Image key={0} style={{ width: 66, height: 58 }} source={require('./resource/b.png')}></Image>);
              this.setState({ imagen1: imagen })
              this.setState({ texto1: "BUSCANDO..." })
            });
          });
        })
      }

    })


  }


  RastreoPasivo() {
    AsyncStorage.getItem('id_cliente', (err, data) => {
      if (data !== null) {
        this.setState({ inicio: true })
        CargarIbeacoins().then(data => {
          var Regions = data;
          Beacons.detectIBeacons()
          try {
            for (let i = 0; i < Regions.length; i++) {
              Beacons.stopMonitoringForRegion(Regions[i]);
            }
            for (let i = 0; i < Regions.length; i++) {
              Beacons.startMonitoringForRegion(Regions[i]);
            }
            ToastAndroid.show("HAS HABILITADO EL RASTREO DE BEACOINS ", ToastAndroid.SHORT);
          } catch (err) {
            ToastAndroid.show('NO SE COMENZO EL MONITOREO DE REGIONES, ERROR: ${err}', ToastAndroid.LONG);
          }

          DeviceEventEmitter.addListener('regionDidEnter', (region) => {
            CargarProductos().then(productos => {
              CargarTipo().then(tipo => {
                for (let i = 0; i < tipo.length; i++) {
                  if (region.identifier == tipo[i].identifier && productos[0].id_tipo == tipo[i].id_tipo) {
                    let imagen = [];
                    imagen.push(<Image key={0} style={SInicio.imagen} source={{ uri: productos[0].imagen }}></Image>);
                    this.setState({ texto1: productos[0].descripcion })
                    this.setState({ imagen1: imagen })
                    PushNotification.localNotificationSchedule({
                      id: '1',
                      message: productos[0].descripcion,
                      date: new Date(Date.now()),
                    });
                    break;
                  }
                }

              })
            })
            DeviceEventEmitter.addListener('regionDidExit', (region) => {
              let imagen = [];
              imagen.push(<Image key={0} style={{ width: 66, height: 58 }} source={require('./resource/b.png')}></Image>);
              this.setState({ imagen1: imagen })
              this.setState({ texto1: "BUSCANDO..." })
            });
          });
        })
      }

    })
  }
}
export const SInicio = StyleSheet.create({
  Contenedor: {
    flex: 1,
    flexDirection: 'column',
  },
  imagen: {
    width: width(90),
    height: height(40),
    borderRadius: 10,
  },
  Cimagen: {
    width: width(100),
    height: height(50),
    alignItems: "center",
    justifyContent: "center",
    paddingTop: 20,
    paddingBottom: 20,
    color: '#fff',
    textAlign: 'center',
    backgroundColor: '#ffffff',
    borderBottomWidth: 5,
    borderColor: '#FAD02C'
  },
  Ctexto: {
    width: width(100),
    height: height(50),
    alignItems: "center",
    justifyContent: "center",
    paddingTop: 20,
    paddingBottom: 20,
    textAlign: 'center',
    backgroundColor: '#FAD02C'
  },
  Texto: {
    fontSize: totalSize(4),
    color: '#fff',
    width: width(80),
    textAlign: 'center',
    backgroundColor: '#3F51B5',
    borderRadius: 4,
    padding: 10,
    borderWidth: 5, 
    borderColor: '#1A34B2'
    
  },
  ContenedorInicio:{
    alignItems: "center",
    marginTop: Dimensions.get('window').height /6,
  },
  contenendor: {
    flex: 1,
  },
  nav: {
    flexDirection: 'row',
    height: Dimensions.get('window').height / 9 + 7,
    backgroundColor: "#FAD02C",
    justifyContent: 'center',
    borderWidth: 3,
    borderColor: '#FAD02C',
  },
  CentradoTitulo: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  Titulo: {
  
    fontSize: ((Dimensions.get('window').width / 3) / 4),
    color: '#3F51B5'
  },
  body: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center'
  }, campos: {
    width: Dimensions.get('window').width / 1.5
  },
  btnIniciarSesion: {
    width: Dimensions.get('window').width / 1.5,
    height: Dimensions.get('window').width / 5,
    marginTop: 5,
    justifyContent: 'center',
    alignItems: 'center',
    borderRadius: 4,
    borderWidth: 2,
    borderColor: '#3F51B5',
    backgroundColor: '#3F51B5',
  },
  TituloBoton: {
    color: 'white',
    fontSize: Dimensions.get('window').width / 15
  }

});

export default App;

