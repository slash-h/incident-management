using {
  cuid,
  managed,
  sap.common.CodeList
} from '@sap/cds/common';

namespace sap.capire.incidents;

entity Customers : managed {
  key ID           : Integer;
      firstName    : String;
      lastName     : String;
      name         : String = trim(firstName || ' ' || lastName);
      email        : EmailAddress;
      phone        : phoneNumber;
      creditCardNo : String(16) @assert.format: '^[1-9]\d{15}$';
      address      : Composition of many Addresses
                       on address.customer = $self;
      incidents    : Association to many Incidents
                       on incidents.customer = $self;
}

entity Addresses : cuid, managed {
  customer      : Association to Customers;
  city          : String;
  postCode      : String;
  streetAddress : String;
}

entity Incidents : cuid, managed {
  customer     : Association to Customers;
  title        : String @title: 'Title';
  urgency      : Association to Urgency default 'M';
  status       : Association to Status default 'N';
  conversation : Composition of many {
                   key ID        : UUID;
                       timestamp : type of managed : createdAt;
                       author    : type of managed : createdBy;
                       message   : String;
                 }
}

entity Urgency : CodeList {
  key code : String enum {
        high = 'H';
        medium = 'M';
        low = 'L'
      }
}

entity Status : CodeList {
  key code        : String enum {
        new = 'N';
        assigned = 'A';
        in_progress = 'I';
        on_hold = 'H';
        resolved = 'R';
        closed = 'C';
      };
      criticality : Integer;

}

type EmailAddress : String;
type phoneNumber  : String;
