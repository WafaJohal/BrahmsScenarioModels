object DoorBell instanceof Bell {
	initial_beliefs:
	(Campanile_Clock.time = 1);
		(current.perceivedtime = 1);

	initial_facts:
	(Campanile_Clock.time = 1);
		(current.perceivedtime = 1);
		
		//generate a random time arround 18h
		// broad cast a signal at that point

}
