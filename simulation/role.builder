var roleBuilder = {

    /** @param {Creep} creep **/
    run: function(creep) {

	    if(creep.memory.building && creep.carry.energy == 0) { 
	    /*If it runs out of energy while building*/
            creep.memory.building = false;
            /*Stop building*/
            creep.say('🔄 harvest');
            /*Switch to harvesting*/
	    }
	    if(!creep.memory.building && creep.carry.energy == creep.carryCapacity) {
	    /*If it's not building and it fills up it's energy*/
	        creep.memory.building = true;
	        /*Stop harvesting*/
	        creep.say('🚧 build');
	        /*Switch to building*/
	    }

	    if(creep.memory.building) {
	    /*During building phase*/
	        var targets = creep.room.find(FIND_CONSTRUCTION_SITES);
	        /*Find unfinished buildings*/
            if(targets.length) {
                if(creep.build(targets[0]) == ERR_NOT_IN_RANGE) {
                    creep.moveTo(targets[0], {visualizePathStyle: {stroke: '#ffffff'}});
                }
            }
	    }
	    else {
            /*During harvesting phase*/
	        var sources = creep.room.find(FIND_SOURCES);
	            /*Find energy sources to harvest*/
            if(creep.harvest(sources[0]) == ERR_NOT_IN_RANGE) {
                /*If energy source is out of range*/
                creep.moveTo(sources[0], {visualizePathStyle: {stroke: '#ffaa00'}});
                    /*Move to energy source*/
            }
	    }
	}
};

module.exports = roleBuilder;