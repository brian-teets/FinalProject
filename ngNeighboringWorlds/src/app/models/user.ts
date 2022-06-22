export class User {
  id: number | null;
  username: string | null;
  password: string | null;
  email: string | null;
  role: string | null;

constructor(
  id: number | null = 0,
  username: string | null = '',
  password: string | null = '',
  email: string | null = '',
  role: string | null = ''
){
  this.id = id;
  this.username = username;
  this.password = password;
  this.email = email;
  this.role = role;
}


}

