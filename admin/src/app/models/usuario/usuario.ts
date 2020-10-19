export class Usuario {
  constructor(
    public uuid: string,
    public id_persona: number,
    public primernombre: string,
    public segundonombre: string,
    public primerapellido: string,
    public segundoapellido: string,
    public usuario: string,
    public direccion: string,
    public nit: string,
    public telefono: string,
    public rol: string
  ) { }
}
