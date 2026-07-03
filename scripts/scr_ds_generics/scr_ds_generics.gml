/// @desc Struct that holds the information about a singular component of a given attack - typically a source of damage, healing, or the like.
/// @param {string} title The name of the component
/// @param {real} baseVal The base numerical value of this component, EG: the base damage of an attack
/// @param {Struct.infoStatScaling} scaling The stat scaling of this component, EG: what % of Phys Dmg does this ability scale with
/// @param {enum<attackDmgTypeEnum>} [dmgType] The damage type of this attackcomponent, if it deals damage. Optional, defaults to `abilDmgTypeEnum.typeNone`. Uses `abilDmgTypeEnum` enum.
/// @param {enum<elementTypes>} [dmgElement] The elemental type of this attack component, if it deals damage. Optional, defaults to `elementTypes.eNone`. Uses `elementTypes` enum.
function infoAttackComponent(title, baseVal, scaling, dmgType = attackDmgTypeEnum.typeNone, elemType = elementTypes.eNone) constructor {
	attCompTitle = title;
	attCompBaseValue = baseVal;
	attCompScaling = scaling;
	attCompDmgType = dmgType;
	attCompElemType = elemType;
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