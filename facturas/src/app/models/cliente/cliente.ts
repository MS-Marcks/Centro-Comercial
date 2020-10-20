export class Cliente {
  constructor(
    public id_persona: number,
    public primernombre: string,
    public segundonombre: string,
    public primerapellido: string,
    public segundoapellido: string,
    public usuario: string,
    public direccion: string,
    public nit: string,
    public telefono: string
  ) { }
}
