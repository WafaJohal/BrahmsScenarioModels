area MOCA_Geography instanceof World {}

areadef House extends Building { }

areadef School extends Building { }

areadef Office extends Building { }

areadef Room extends BaseAreaDef {}


// Grenoble
area Grenoble instanceof City partof MOCA_Geography { }

// inside Grenoble
area Mokas_House instanceof House partof Grenoble { }
area Charlemagne_School_Building instanceof School partof Grenoble { }

//Inside Mokas_house
area living_Room instanceof Room partof Mokas_House {}
area atDesk instanceof Room partof Mokas_House {}

//path
path CSchool_to_from_MokasHouse {
	area1: Charlemagne_School_Building;
	area2: Mokas_House;
	distance: 1200;
}

//path
path CLivingRoom_to_from_Desk {
	area1: living_Room;
	area2: atDesk;
	distance: 240;
}