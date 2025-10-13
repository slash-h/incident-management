using {sap.capire.incidents as my} from '../db/schema';

// Service used by service personnel
service ProcessorService {
  entity Incidents as projection on my.Incidents;

  @readonly
  entity Customers as projection on my.Customers;
}

// Service used by Administrator
service AdminService {

  entity Incidents as projection on my.Incidents;
  entity Customers as projection on my.Customers;

}
