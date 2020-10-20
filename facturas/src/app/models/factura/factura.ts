export class Factura {
  constructor(
    public id_factura: number,
    public id_cliente: number,
    public nit: string,
    public direccion: string,
    public empleado: string,
    public cliente: string,
    public total: number,
    public estado: string
  ) {

  }
}
