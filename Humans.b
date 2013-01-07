group Humans {

	attributes:
		public boolean male;
		public double howHungry;
		public int perceivedtime;
		public boolean hasEaten;
		public double howRelaxed;
		public boolean communicationStarted;
		public boolean isFree;
		public int howBored;
		
	relations:
	
	
	initial_beliefs:
		(current.hasEaten = false);
		(current.communicationStarted = false);
		(current.howRelaxed = 10); 
		
	activities:
		// move to some place loc
		move moveToLocation(Building loc) {
			 location: loc;
		}
			move moveToRoom(Room loc) {
			 location: loc;
		}
		
		// busy wathcing tv
		primitive_activity watchTv(){
				min_duration: 200; //
				max_duration: 1000;
		}

		//busy eating
		primitive_activity eat() {
				max_duration: 400;
		}

		//GOING T
	workframes:
		
		workframe wf_getFood {

				repeat: true;
			
				when(knownval(current.howHungry > 20.00) and
					knownval(current.location = Mokas_House))

				do	{
				eat();
					conclude((current.howHungry= current.howHungry - 5), bc:100); 
				}
			}
			//watch tv when already in living room
			workframe wf_watchTv {

				repeat: true;
			
				when(knownval(current.location = living_Room) and knownval(current.howRelaxed < 20))

				do	{
				watchTv();
					conclude((current.howRelaxed = current.howRelaxed + 5), bc:100); 
				}
			}
			//wathc tv when not in living room
				workframe wf_watchTv2 {

				repeat: true;
			
				when(knownval(current.howRelaxed < 20) and knownval(current.location != living_Room))

				do	{
				moveToRoom(living_Room);
				watchTv();
					conclude((current.howRelaxed = current.howRelaxed + 5), bc:100); 
				}
			}


		thoughtframes:
		
			thoughtframe tf_feelHungry {
					repeat: true;

					when(knownval(Campanile_Clock.time > current.perceivedtime))

					do {
						conclude((current.perceivedtime = Campanile_Clock.time), bc: 100);
						conclude((current.howHungry = current.howHungry + 3.00), bc:50);

					}

				}
		

}
