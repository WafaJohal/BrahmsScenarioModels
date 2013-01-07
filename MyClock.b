class MyClock extends BaseClass {
	attributes:
		public int time;

	
	activities:

			primitive_activity asTimeGoesBy() {
						random: false;
						max_duration: 3599;//minutes during the day
			}
	

			broadcast announceTime() {
						random: false;
						max_duration: 1;

						about: 
							send(current.time = current.time);

						when: end;	 
			}
			
	workframes:

			
			workframe wf_asTimeGoesBy {
					repeat: true;
				            
					when(knownval(current.time < 20))	
					// after 20 hours the model halts - that's a long working day!
					
						
					do {
						asTimeGoesBy();
						conclude((current.time = current.time + 1), bc:100, fc:100);
						announceTime();
					}
			}	

}
