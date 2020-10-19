export class Compra {
  constructor(
    public id_compra: number,
    public id_proveedor: number,
    public proveedor: string,
    public id_articulo: number,
    public articulo: string,
    public cantidad: number,
    public precio: number,
    public total: number
  ) { }
}
