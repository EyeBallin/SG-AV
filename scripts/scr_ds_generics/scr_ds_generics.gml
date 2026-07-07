/// @desc Struct that holds the information about a singular component of a given attack - typically a source of damage, healing, or the like.
/// @param {string} title The name of the component
/// @param {real} baseVal The base numerical value of this component, EG: the base damage of an attack
/// @param {Struct.infoStatScaling} scaling The stat scaling of this component, EG: what % of Phys Dmg does this ability scale with.
/// @param {Enum.attackDmgTypeEnum} dmgType The damage type of this attackcomponent, if it deals damage. Uses `abilDmgTypeEnum` enum.
/// @param {Enum.elementTypes} elemType The elemental type of this attack component, if it deals damage. Uses `elementTypes` enum.
/// @param {Enum.dmgResHitTypeEnum} resHit The resistance this attack hits. Uses `dmgResHitTypeEnum` enum.
/// @param {Array<Struct.infoAttStatusEffect>} [statusEffects] The status effects this component applies. Optional, default is empty array.
/// @param {Array<Struct.infoAttOnHitEffect>} [inhOnHits] The inherent on-hit effects of this component. Optional, default is empty array.
/// @param {real} [inhPierce] Inherent piercing of this attack component, if it is a projectile. Optional, -1 is infinite, default is 0.
/// @param {real} [inhLS] Inherent lifesteal of this attack component, if it deals damage. Optional, defauls to 0.
/// @param {boolean} [appliesOnHit] Whether this applies on-hit effects. Optional, default is false.
/// @return {Struct.infoAttackComponent}
function infoAttackComponent(title, baseVal, scaling, dmgType, elemType, resHit, statuses = [], inhOnHits = [], 
	inhPierce = 0, inhLS = 0, appliesOnHit = false) constructor {
		attCompTitle = title;
		attCompBaseValue = baseVal;
		attCompScaling = scaling;
	  attCompStatusEffects = statuses;
		attCompInherentOnHits = inhOnHits;
		attCompDmgType = dmgType;
		attCompElemType = elemType;
		attCompResHit = resHit;
	  attCompInherentPierce = inhPierce;
	  attCompInherentLS = inhLS;
	  attCompAppliesOnHit = appliesOnHit;
}

/// @desc Struct that holds stat scaling info. All values are percentages.
/// @param {real} statPhys Physical Damage
/// @param {real} statEner Energy Damage
/// @param {real} [statHPCurr] Current HP
/// @param {real} [statHPMax] Max HP
/// @param {real} [statHPMissing] Current Missing HP
/// @param {real} [statEnemyHPCurr] Target's Current HP
/// @param {real} [statEnemyHPMax] Target's Max HP
/// @param {real} [statEnemyHPMissing] Target's Missing HP
/// @param {real} [statManaCurr] Current Mana
/// @param {real} [statManaMax] Max Mana
/// @param {real} [statManaMissing] Current Missing Mana
/// @param {real} [statAttSpd] Attack Speed
function infoStatScaling(statPhys, statEner, statHPCurr = 0, statHPMax = 0, statHPMissing = 0, 
statEnemyHPCurr = 0, statEnemyHPMax = 0, statEnemyHPMissing = 0, 
statManaCurr = 0, statManaMax = 0, statManaMissing = 0, statAttSpd = 0) constructor {
  scalePhys = statPhys;
  scaleEner = statEner;
  scaleHPCurr = statHPCurr;
  scaleHPMax = statHPMax;
  scaleHPMissing = statHPMissing;
  scaleEnemyHPCurr = statEnemyHPCurr;
  scaleEnemyHPMax = statEnemyHPMax;
  scaleEnemyHPMissing = statEnemyHPMissing;
  scaleManaCurr = statManaCurr;
  scaleManaMax = statManaMax;
  scaleManaMissing = statManaMissing;
  scaleAttSpeed = statAttSpd;
}

/// @desc Info regarding status effects that the action can apply.
/// @param {Enum.statusEffects} seId ID of the status effect that can be applied.
/// @param {Real} [seDur] Duration multiplier of the status effect. Optional, default is x1.
/// @param {Real} [seStrength] Strength of the status effect application. Optional, default is x1.
/// @param {Real} [seStacks] How many stacks of the status effect this action applies. Optional, default is 1.
/// @param {Real} [seChance] Chance between 0 and 1 for the status effect to apply. Optional, defaults to 1 (100%)
/// @returns {Struct.infoAttStatusEffect} Status effect component info struct
function infoAttStatusEffect(seId, seDur = 1, seStrength = 1, seStacks = 1, seChance = 1) constructor {
  infoSEID = seId;
  infoSEDur = seDur;
  infoSEStrength = seStrength;
  infoSEStacks = seStacks;
  infoSEChance = seChance;
}

/// @desc Info regarding on-hit effects that the action can apply
/// @param {Enum.onHitIDs} ohID onHitID, ID of the on-hit effect that can be applied
/// @param {Real} [ohDur] Duration multiplier of on-hit effect (EG status effects). Optional, def is 1
/// @param {Real} [ohStr] Strength multiplier of on-hit effect. Optional, def is 1
/// @param {Real} [ohStacks] Stacks of on-hit effect applied (if status effect). Optional, def is 1
/// @param {Real} [ohChance] Chance of on-hit effect triggering. Optional, defaults to 1
function infoAttOnHitEffect(ohID, ohDur = 1, ohStr = 1, ohStacks = 1, ohChance = 1) constructor {
	infoOHID = ohID;
	infoOHDur = ohDur;
	infoOHStrength = ohStr;
	infoOHStacks = ohStacks;
	infoOHChance = ohChance;
}

/// @desc Calculate a final damage value, using a base value, a stat scaling struct, and an entity with stats to scale from
/// @arg {real} baseVal A base value to begin with
/// @arg {struct.infoStatScaling} statScalings A stat scaling struct to use
/// @arg {asset.GMObject} entityToUse A child instance of `obj_abs_entity` to use as the source of stats
function calcFinalDmgVal(baseVal, statScalings, entityToUse) {
    //TODO
    var finalNum = baseVal;
    
    return finalNum;
}

/// @desc Creates a string giving a basic readout of a value's stat scaling. EG:
/// "375 (300 + 25[PhysDmgIcon] + 50[EnerDmgIcon])"
/// @arg {real} baseVal A base value to begin with
/// @arg {struct.infoStatScaling} statScalings A stat scaling struct to use
/// @arg {asset.GMObject} entityToUse A child instance of `obj_abs_entity` to use as the source of stats
function createStatScalingString(baseVal, statScalings, entityToUse) {
    //TODO
    var statString = "";
    
    return statString;
}

/// @desc Creates a string giving a detailed readout of a value's stat scaling. EG: 
/// "Damage: 300 Base
/// (+25[PhysDmgIcon]) (50% of Physical Dmg)
/// (+50[EnerDmgIcon]) (50% of Energy Dmg)"
/// @arg {real} baseVal A base value to begin with
/// @arg {struct.infoStatScaling} statScalings A stat scaling struct to use
/// @arg {asset.GMObject} entityToUse A child instance of `obj_abs_entity` to use as the source of stats
function createStatScalingStringDescriptive(baseVal, statScalings, entityToUse) {
    //TODO
    var statString = "";
    
    return statString;
}