import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-new-event',
  templateUrl: './new-event.component.html',
  styleUrls: ['./new-event.component.css']
})
export class NewEventComponent implements OnInit {

  eventList: CultureEvent[] = [];
  selected: cult | null = null;
  newFlight: Event = new Flight();
  editFlight: Flight | null = null;

  constructor(private flightSvc: FlightsService) {}

  ngOnInit(): void {
    this.reload();
  }

  reload() {
    this.flightSvc.index().subscribe({
      next: (data) => {
        this.flightList = data;
      },
      error: (wrong) => {
        console.error('FlightComponent.reload: error loading list');
        console.error(wrong);
      },
    });
  }

  getFlightCount(): number {
    return this.flightList.length;
  }

  displayFlightInfo(flight: Flight): void {
    this.selected = flight;
  }

  addFlight(flight: Flight): void {
    this.flightSvc.create(flight).subscribe({
      error: (wrong) => {
        console.error('error creating flight');
        console.error(wrong);
      },
    });
    this.reload();
    this.newFlight = new Flight();
    this.displayFlightInfo(flight);
  }

  setEditFlight(): void {
    this.editFlight = Object.assign({}, this.selected);
  }
  updateFlight(flight: Flight, setSelected: boolean = true): void {
    if (flight.id != null) {
      this.flightSvc.update(flight.id, flight).subscribe({
        next: (updatedFlight) => {
          this.reload();
          this.editFlight = null;
          if (setSelected) {
            this.selected = updatedFlight;
          }
        },
        error: (wrong) => {
          console.error('error completing flight');
          console.error(wrong);
        },
      });
    }
  }

  deleteFlight(id: number): void {
    console.log('in delete');
    this.flightSvc.destroy(id).subscribe({
      next: () => {
        this.reload();
      },
      error: (wrong) => {
        console.error('error deleting flight');
        console.error(wrong);
      },
    });
  }
}

