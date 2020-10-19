export class Horario {
    constructor(
      public id_horario: number,
      public uuid:string,
      public hora_entrada: string,
      public hora_salida: string,
      public usuario: string
    ){}
}
