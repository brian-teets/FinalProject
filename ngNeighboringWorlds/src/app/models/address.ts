export class Address {
  id: number;
  address1: String;
  address2: String;
  city: String;
  state: String;
  zipCode: String;
  country: String;

  constructor(
    id: number = 0,
    address1: String = '',
    address2: String = '',
    city: String = '',
    state: String = '',
    zipCode: String = '',
    country: String = ''
  ) {
    this.id = id;
    this.address1 = address1;
    this.address2 = address2;
    this.city = city;
    this.state = state;
    this.zipCode = zipCode;
    this.country = country
  }
}
