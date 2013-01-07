agent Prof memberof Companions, Family_Moka {

		location: living_Room;
	
	attributes:
		public boolean needTodoHomework;
		public int homeworkTime;	
		public string perceivedList_homework;
		public boolean homeworkComplete;
		public boolean homeworkStarted;
	relations:

	initial_beliefs:
		(current.homeworkTime = 18);
		(Campanile_Clock.time = 1);
		(current.perceivedtime = 1);
		(current.needTodoHomework = false);
		(current.communicationStarted = false);
		(current.homeworkComplete = false);
		(current.homeworkStarted = false);
	
	initial_facts:
		
	activities:
			//schedule the different exercises
			primitive_activity scheduleHMK_Exercices() {
				max_duration: 1500;
			}
			
			//load an exercices for hmk
				primitive_activity load_Exercices() {
				max_duration: 1500;
			}
		
			//communicate the need to do the homework
			communicate communicateTimeForHomework() {
				max_duration: 10;
				with: Ben;
				about:
					send(current.needTodoHomework);
				when: end;
			}	
			
				//communicate the time for the homework is over
			communicate communicateEndOfHomework() {
				max_duration: 10;
				with: Ben;
				about:
					send(current.stopHomework);
				when: end;
			}
			
	/*	communicate communicateAskForAgenda() {
				max_duration: 10;
				with: Virtual_Agenda;
				about:
					receive(Virtual_Agenda.list_homework);
				when: end;
			}	*/
	
	workframes:
		workframe wf_DemandToDoHomework{
     	repeat: true;
			priority: 1;
			when(knownval(current.needTodoHomework = true) and knownval(current.communicationStarted = false))
			do
			{
				conclude((current.communicationStarted = true), bc:100, fc:100);
			  communicateTimeForHomework(); 	    		  
    	}
		}
		
	thoughtframes:
			// Belief that its time to do the homework
			thoughtframe tf_NeedTodoHomework{
						repeat: true;
						when(knownval(current.perceivedtime = current.homeworkTime) 
							and knownval(current.needTodoHomework = false))
						do {
							conclude((current.needTodoHomework = true), bc: 100,  fc:100);
						}
			
			}
			
			// Belief that the time to do the homework is over
			/* maybe deivied in 2 case
				(1) the homeworks have been completed 
						-> conclude a resume for the parents with congratulation for the kids
				(2) the homeworks havent been completed
						-> conclude a reschedule and a reminider for the kid
			*/
				thoughtframe tf_TimeForHomeworkOver{
						repeat: true;
						when(knownval(current.perceivedtime >= 19) 
							and knownval(current.needTodoHomework = true))
						do {
							conclude((current.needTodoHomework = false), bc: 100,  fc:100);
							
						}
			
			}
				thoughtframe tf_perceivedMotivationOfChild{
						repeat: true;
						when(knownval(Ben.acceptTodoHomework = true))
						do {
							conclude((current.needToMotivate = false), bc: 80,  fc:100);
						}
			
			}
				thoughtframe tf_perceivedMotivationOfChild2{
						repeat: true;
						when(knownval(Ben.acceptTodoHomework = false))
						do {
							conclude((current.perceivedMotivationRate = Ben.motivationRate), bc: 100, fc:100);
							conclude((current.needToMotivate = true), bc: 80,  fc:100);
							//wf_Motivation() to do a new wf with condition need to motivated
							
						}
			
			}
		

}
