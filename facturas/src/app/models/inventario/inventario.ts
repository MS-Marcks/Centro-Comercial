export class Inventario {
  constructor(
    public id_articulo: number,
    public id_tienda: number,
    public tienda: string,
    public id_tipo: number,
    public tipo: string,
    public articulo: string,
    public descripcion: string,
    public precio: number,
    public stock: number,
    public imagen: string
  ) { }
}
