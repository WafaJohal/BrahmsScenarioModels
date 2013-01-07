agent Ben memberof Family_Moka, Children{
	location: living_Room;

	initial_beliefs:
		(current.howHungry = 15.00);
		(Campanile_Clock.time = 1); // 990 = 16Hh30
		(current.perceivedtime = 1);
		(current.male = true);

	initial_facts:
		(current.male = true);
	
	

}
