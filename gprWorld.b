group gprWorld {

attributes:
		public double perceivedtime;
		public boolean simulationOver;
		protected Room roomTogoto;
		protected Building buildingTogoto;
		protected string listOfActions;
			public gprWorld whoIam;
	
			
initial_beliefs:
		(Campanile_Clock.time = 15.0);
		(current.perceivedtime = 15.0);
		(current.simulationOver = false);
		(current.listOfActions ="");
		//(current.roomTogoto = current.location);
		//(current.buildingTogoto = current.location);
		
activities:
		//to move to a certain location by precispint the time
		move moveToLocation(string name, int maxDuration, BaseAreaDef loc) {
				display: "move to";
				max_duration: maxDuration;
				location: loc;
		}
			// move to a building according to the geography
		move moveToBuilding(Building loc) {
			 location: loc;
		}
		// move to a room according to the geography
			move moveToRoom(Room loc) {
			 location: loc;
		}
		
		//communications
		//go to room
			communicate communicateGoToRoom(gprWorld agt, string name) {
					display : name ; 
					max_duration: 4;
					with: agt;
					about:
						send(current.roomTogoto),
						receive(agt.location);
					when: end;
				}
		//communications
		//go to building
			communicate communicateGoToBuilding(gprWorld agt, string name) {
					display : name; 
					max_duration: 4;
					with: agt;
					about:
						send(current.buildingTogoto),
						receive(agt.location);
					when: end;
				}
				
					//communications
		//give a feedback to aonter agent about the actions performed
			communicate communicateListOfActionsPerformed(gprWorld agt, string name) {
					display : name; 
					max_duration: 4;
					with: agt;
					about:
						send(current.listOfActions);
					when: end;
				}
				
					 //communicate who i am
			communicate communicateWhoIam(gprWorld agt) {
					max_duration: 10;
					with: agt;
					about:
						send(current.whoIam);
				when: end;
				} 
				
				
			//listen to a song activity
			//eventually create song object that has also a feelingGood factors
			primitive_activity listenToMusic( string nameOfTheSong, int durationOfSong){
				display : nameOfTheSong; 
					max_duration: durationOfSong;
			}
			//simple general activity
				primitive_activity simpleActivity(string name, int duration) {
				display: name;
				max_duration: duration;
			}

workframes:
	workframe wf_halt {
    	repeat: true;
			priority: 1;
    	when(knownval(current.perceivedtime >= 21.0) )
   		do
			{
				conclude((current.simulationOver = true),bc:100,fc:100); 
     	}
   }  
	thoughtframes:
			thoughtframe tf_perceiveTime {
					repeat: true;
					priority: 1;
					when(knownval(Campanile_Clock.time > current.perceivedtime))

					do {
						conclude((current.perceivedtime = Campanile_Clock.time), bc: 100);
					}
				}
}
