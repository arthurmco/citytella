module citytella.core.EntityManager;

import std.container.array;
import citytella.core.Entity;

/* An entity manager manages the engine.

   Its primary function is to run the 'entity code', the life of said entity.
   It manages the addition and deletion of the entity too.
*/

/* The entity unit */
struct EntitySlot {
    Entity e;              // The said entity
    ulong last_timestamp;  // The timestamp of last iteration, in ms.
};



class EntityManager {
private:
    ulong actual_timestamp = 0;
    auto lstEntities = Array!(Entity)();
    
public:

    static EntityManager ef = null;
    static ref EntityManager getEntityManager() {
	if (!ef) ef = new EntityManager();

	return ef;
    }

    /* Adds an entity */
    void addEntity(ref Entity e) {
	lstEntities.insert([e]);
    }

    /* Removes an entity. 
       Returns false if id not found, or true if removed */
    bool removeEntity(uint id) {
	if (lstEntities.empty) return false;

	auto i = 0;
	foreach(ref Entity ent ; lstEntities) {
	    if (ent.ID == id) {
		// hack to make it remove just one
		lstEntities.linearRemove(lstEntities[i..i+1]);
		return true;
	    }
	    i++;
	}

	return false;
    }

    ref Entity getEntity(uint id) {
	foreach(ref Entity ent ; lstEntities) {
	    if (ent.ID == id) {
		return ent;
	    }
	}

	//TODO: throw exception?
	throw new Exception("Unexistant entity");
    }

    Entity*[] getEntities(string name) {
	auto ei = 0;
	Entity*[] es;

	foreach(ref Entity ent ; lstEntities) {
	    if (ent.name == name) {
		es[ei] = &ent;
		ei++;
	    }
	}

	return es;
    }


    /* Iterate through all of the entity manager list members */
    void iterate() {
	foreach (ref Entity ent ; lstEntities) {
	    ent.iterate();
	}

    }

}
