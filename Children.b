group Children memberof Humans {
	
	attributes:
		public boolean readyToLeaveSchool;
		public int motivationRate;
		public boolean acceptTodoHomework;
		public int motivatedEnoughForHomework;
		public int motivatedEnoughForPlaying;
		public int motivatedEnoughForCoaching;
		
	relations:
	

		//ATTRIBUTES AND RELATIONS SCOPES ARE ALL SET TO PUBLIC. PRIVATE AND PROTECTED SCOPES ARE ADMITTED BUT NOT YET IMPLEMENTED IN THE CURRENT VERSION OF THE LANGUAGE

	initial_beliefs:
		(current.readyToLeaveSchool = false);
		(current.acceptTodoHomework = false);
		(current.motivationRate = 40);
		(current.motivatedEnoughForHomework = 70);
		(current.motivatedEnoughForPlaying = 20);
		(current.motivatedEnoughForCoaching = 40);
		
	activities:
		primitive_activity study() {
			max_duration: 1500;
		}
		
		communicate communicateRefuseToDoHomework() {
			max_duration: 10;
			with: Prof;
			about:
				send(current.motivationRate),
				send(current.acceptTodoHomework),
				send(Prof.needToMotivate = true);
			when: end;
		}
		
		communicate communicateAcceptToDoHomework1() {
			max_duration: 10;
			with: Prof;
			about:
				send(current.acceptTodoHomework),
				send(Prof.needToMotivate = false);
			when: end;
		} 
	


		//GOING T
	workframes:

		workframe wf_moveToHome {
					repeat: true;

					variables:
					
					
					when(knownval(current.perceivedtime = 16) and				        
						not(current.location = Mokas_House) and 
						(current.location = Charlemagne_School_Building)) 
				
						
					do {
						moveToLocation(Mokas_House);	
						moveToRoom(living_Room);	
					}
		}
				
		workframe wf_moveToSchool {
					repeat: true;

					variables:
					
					
					when(knownval(current.perceivedtime = 8) and				        
						not(current.location = Charlemagne_School_Building) and
						(current.location = Mokas_House)) 
				
						
					do {
						moveToLocation(Charlemagne_School_Building);	
						study();
					}
		}
	
			workframe wf_doHomework {
					repeat: true;

					variables:
					
					
					when(knownval(current.acceptTodoHomework = true) and				        
						not(current.location = atDesk) 
						/* and (current contains textbook)*/) 
				
					do {
						moveToRoom(atDesk);	
						study();
					}
		}
		
		workframe wf_study {

				repeat: true;
			
				when(knownval(current.perceivedtime < 16) and	knownval(Campanile_Clock.time < 16)		        
				and	knownval(current.location = Charlemagne_School_Building))

				do	{
				study();
				conclude((current.howHungry= current.howHungry + 1), bc:100); 
				conclude((current.howRelaxed= current.howRelaxed - 3), bc:100);
				}
		}

	workframe wf_AcceptTodoHomework1 {
    	repeat: true;
			priority: 1;
    	when(knownval(Prof.needTodoHomework = true)  and
					knownval(current.motivationRate >= current.motivatedEnoughForHomework)) //TODO aDD COMPOSANTE OF MOTIVATION
   		do
			{
				conclude((current.communicationStarted = true),bc:100,fc:100);
				conclude((current.acceptTodoHomework = true),bc:100,fc:100);
    		communicateAcceptToDoHomework1();
     	}
   }   
	workframe wf_RefuseTodoHomework {
    	repeat: true;
			priority: 1;
    	when(knownval(Prof.needTodoHomework = true) 
					and knownval(current.motivationRate < current.motivatedEnoughForHomework)) 
   		do
			{
				conclude((current.communicationStarted = true),bc:100,fc:100);
				conclude((current.acceptTodoHomework = false),bc:100,fc:100);
    		communicateRefuseToDoHomework();

     	}
   }  
	
	//TODO
		thoughtframes:
			thoughtframe tf_hasBeenMotivated{
						repeat: true;
						when(knownval(Prof.hasMotivated = true))
						do {
						 conclude((current.motivationRate = current.motivationRate +10),bc:100,fc:100);
							conclude((Prof.perceivedMotivationRate = current.motivationRate), bc: 100, fc:100);
							conclude((Prof.needToMotivate = true), bc: 80,  fc:100);
							//wf_Motivation() to do a new wf with condition need to motivated
							
						}
			
			}
		
			
}
