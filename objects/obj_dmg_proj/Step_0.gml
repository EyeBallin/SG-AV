xPrev = x;
yPrev = y;
x += lengthdir_x(projSpdCurr, projDir);
y += lengthdir_y(projSpdCurr, projDir);
projSpdCurr += projAcc;

projDist += point_distance(xPrev, yPrev, x, y);

if (projSprRotDir)
	image_angle = projDir;

var collCheck = obj_abs_entity;
if (projOwner.entityType == entityTypes.ePlayer || projOwner.entityType == entityTypes.eAlly)
	collCheck = obj_enemy;
if (projOwner.entityType == entityTypes.eEnemyBoss || projOwner.entityType == entityTypes.eEnemyNormal || projOwner.entityType == entityTypes.eEnemyMinion)
	collCheck = obj_sg_av;

//If moving fast, do line checks instead of place checks.
//This kinda sucks if the projectile's both really fast and really wide, but alternate solutions use a LOT more processing per projectile.
var collCount = 0;
if (point_distance(x, y, xPrev, yPrev) > sprite_width * 1.5)
	collCount = collision_line_list(xPrev, yPrev, x, y, collCheck, false, true, collList, true);
else
	collCount = instance_place_list(x, y, collCheck, collList, true);
	
if (collCount > 0) {
	// No fucking clue what's going on here with feather but this comment needs to be here
	// Feather disable once GM2016
	collideProjectile(self, collList);
	ds_list_clear(collList);
}

//TODO: Change
if (projSpdCurr <= 0)
	instance_destroy();
	
if (x < 0 || x > room_width || y < 0 || y > room_height) {
	projOOB -= 1;
	if (projOOB <= 0) {
		instance_destroy();
	}
}