group Companions {

	attributes:
		public boolean communicationStarted;
		public boolean isOccupated;
		public boolean hasMotivated;
		public boolean needToMotivate;
		public boolean stopHomework;
		public int perceivedtime;
		public int perceivedMotivationRate;
	
	relations:

	initial_beliefs:
		(current.communicationStarted = false);
		(current.isOccupated = false);
		(current.hasMotivated = false);
		(current.needToMotivate = false);
		
	activities:
			move moveToLocation(string name, int duration, BaseAreaDef loc) {
				display: name;
				max_duration: duration;
				location: loc;
			}
			primitive_activity simpleActivity(string name, int duration) {
				display: name;
				max_duration: duration;
			}
			
	
	primitive_activity motivate() {
			max_duration: 150;
			
		}
		communicate communicateMotivation(Children ch1) {
					max_duration: 4;
					with: ch1;
					about:
					//	current.motivationRate = current.motivationRate +30;
						send(current.hasMotivated );
					//	send(current.believedPin = current.believedPin);
					when: end;
				}
				
				/*	communicate communicateGoToLoc(Humans ch1) {
					display : "please go to the desk" ; 
					max_duration: 4;
					with: ch1;
					about:
					//	current.motivationRate = current.motivationRate +30;
						send(living_Room);
					//	send(current.believedPin = current.believedPin);
					when: end;
				}*/

	workframes:
		//motivation,
		//TODO AND FINISH IN THE CHILD FILE
		workframe wf_Motivation {
    	repeat: true;
			priority: 1;
			// if motviation rate of Ben is low
			// and is not motivation still
			// and i not occupied doting something else
    	when(knownval(current.needToMotivate = true) )/*and knownval(current.communicationStarted = false)
			and knownval(current.isOccupated = false))*/
   		do
			{
				conclude((current.communicationStarted = true),bc:100,fc:100); //start communication
				conclude((current.hasMotivated = true),bc:100,fc:100);// has motivated becomes true
				conclude((Ben.motivationRate = Ben.motivationRate +15),bc:100,fc:100);
				communicateMotivation(Ben);// 
				//current.hasMotivated = false;
     	}
   }   

	thoughtframes:
			thoughtframe tf_perceiveTime {
					repeat: true;

					when(knownval(Campanile_Clock.time > current.perceivedtime))

					do {
						conclude((current.perceivedtime = Campanile_Clock.time), bc: 100);
					}
				}
		
}
