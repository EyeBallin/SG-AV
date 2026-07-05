/// @desc Standard Shot Code (Common)
/// @param {Id.Instance} shipEnt Ship Entity
/// @param {Struct.infoFormAbility} actInfo Act info struct
/// @param {Real} attTimer Duration until next SS
/// @param {Real} extraProjCount How many extra projectiles are left to create (when att spd > 60)
abilCodeStandardShot = function(shipEnt, actInfo, attTimer, extraProjCount) {
  attTimer += 60/getCurrForm().formSpdAtt.getStatCurr();
  var ssProj = createProjectilePlayer(
    shipEnt.x + (extraProjCount == 0 ? random_range(-15, 15) : 0),
    shipEnt.y-60,
    projIDEnum.ssFire,
    actInfo.abilComponentInfo[0]
  );
  extraProjCount = 1;
  return {retAttTimer: attTimer, retExtraProj: extraProjCount};
};

/// @desc Fireball Code
/// @param {Id.Instance} shipEnt Ship Entity
/// @param {Struct.infoFormAbility} actInfo Act info struct
/// @param {Real} keyState Key State Macro - inputStateHeld, inputStatePressed, or inputStateReleased
/// @param {Bool} autoFire Whether this ability is being set to autofire or not
abilCodePlayerFireQ = function(shipEnt, actInfo, keyState, autoFire) {
  createProjectilePlayer(shipEnt.x, shipEnt.y-60, projIDEnum.spFireFireball, actInfo.abilComponentInfo[0]);
}