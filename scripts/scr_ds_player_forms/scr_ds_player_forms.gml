/// @desc Information structure for an SG-AV form, initialised as a blank slate.
/// @arg {real} newFormID The form number this form uses.
/// @return {struct.infoFormLine}
function infoFormLine(newFormID) constructor {
	formID = newFormID;
	formCol = #808080;
	formName = "Dead Link";
	formDesc = "It's all gone, and they'll never know better.";
	formShot = projIDEnum.ssFire;
  formStats = new infoFormLineStats(100, 100, 1, 1, 1, 15, 0, 0, 0, 0, 0, 0, 0, 0, elementTypes.eNone, 0, 0);
	
	formSwitchToCode = function() {};
	formSwitchFromCode = function() {};
	formStepCode = function() {};
	formDrawCode = function() {};
    
	formSSCode = function(shipEnt, actInfo, attTimer, extraProjCount) {};
	formQCode = function(shipEnt, actInfo, keyState, autoFire) {};
	formWCode = function(shipEnt, actInfo, keyState, autoFire) {};
	formECode = function(shipEnt, actInfo, keyState, autoFire) {};
    
  formSSInfo = new infoFormAbility("abil_name_ss", "abil_desc", "abil_desc_long", 0, 0, []);
  formQInfo = new infoFormAbility("abil_name_q", "abil_desc", "abil_desc_long", 0, 0, []);
  formWInfo = new infoFormAbility("abil_name_w", "abil_desc", "abil_desc_long", 0, 0, []);
  formEInfo = new infoFormAbility("abil_name_e", "abil_desc", "abil_desc_long", 0, 0, []);
}

/// @desc Set all relevant form info for a form struct
/// @arg {struct.infoFormLine} formObj The form struct to set the info of.
/// @arg {constant.Colour} fiCol The colour the form uses.
/// @arg {string} fiName The name of the form.
/// @arg {string} fiDesc A description of the form.
/// @arg {real} fiShot The ID of the standard shot this form uses. Uses `projIDEnum`.
/// @arg {struct.infoFormLineStats} fiStats The stats of the form.
function addFormInfo(formObj, fiCol, fiName, fiDesc, fiShot, fiStats) {
  formObj.formCol = fiCol;
  formObj.formName = fiName;
  formObj.formDesc = fiDesc;
  formObj.formShot = fiShot;
  formObj.formStats = fiStats;
}

/** @desc SG-AV form stats struct.
 * @param {real} hp Base HP.
 * @param {real} mana Base Mana.
 * @param {real} hpRegen Base HP Regen (per second).
 * @param {real} manaRegen Base Mana Regen (per second).
 * @param {real} attSpd Base Attack Speed.
 * @param {real} moveSpd Base Movespeed.
 * @param {real} resColl Base Collision Resistance.
 * @param {real} resProj Base Projectile Resistance.
 * @param {real} resElemFire Base Fire Resistance.
 * @param {real} resElemElec Base Electric Resistance.
 * @param {real} resElemPsn Base Poison Resistance.
 * @param {real} resElemIce Base Ice Resistance.
 * @param {real} resElemLight Base Light Resistance.
 * @param {real} resElemDark Base Dark Resistance.
 * @param {real} formType Form Elemental Type.
 * @param {real} lifestealAtt Base Attack-type Damage Lifesteal.
 * @param {real} lifestealSpell Base Spell-type Damage Lifesteal.
 */
function infoFormLineStats(hp, mana, hpRegen, manaRegen, attSpd, moveSpd, 
resColl, resProj, resElemFire, resElemElec, resElemPsn, resElemIce, resElemLight, resElemDark, 
formType, lifestealAtt, lifestealSpell) constructor {
  fsHP = hp;
  fsMana = mana;
  fsHPRegen = hpRegen;
  fsManaRegen = manaRegen;
  fsAttSpd = attSpd;
  fsMoveSpd = moveSpd;
  fsResColl = resColl;
  fsResProj = resProj;
  fsResElemFire = resElemFire;
  fsResElemElec = resElemElec;
  fsResElemPsn = resElemPsn;
  fsResElemIce = resElemIce;
  fsResElemLight = resElemLight;
  fsResElemDark = resElemDark;
  fsType = formType;
  fsLSAtt = lifestealAtt;
  fsLSSpell = lifestealSpell;
}

/// @desc  Information about a given standard shot
/// @param {string} desc  Brief description of how the standard shot functions.
/// @param {string} descLong Long-form description that includes stat scalings and technical details.
/// @param {Array<struct.infoAttackComponent>} componentsInfo Array of information for each component of the standard shot.
function infoFormSS(desc, descLong, componentsInfo) constructor {
  ssDesc = desc;
  ssDescLong = descLong;
  ssComponentInfo = componentsInfo;
}

/// @desc Information about a given ability, including name, costs, cooldown, etc.
/// @arg {string} name Ability name.
/// @arg {string} desc Brief description of what the ability does.
/// @arg {string} descLong Long-form description that includes damage scalings and technical details.
/// @arg {real} cooldown Base cooldown of the ability in frames (seconds x 60).
/// @arg {real} costMana Base mana cost of the ability.
/// @arg {Array<Struct.infoAttackComponent>} componentsInfo Array of information for each component of the ability (more than 1 used when multiple discreet values are needed).
/// @arg {real} [costHP] Base HP cost. Optional, defaults to `0`.
/// @arg {bool} [costIsPerc] Whether the costs of this ability are a percentage of max resource instead of flat amount. Optional, defaults to `false`.
/// @arg {bool} [isToggle] Whether this ability is a toggle. Optional, defaults to `false`.
/// @arg {bool} [isHoldAndRelease] Whether this ability needs to be held and released to trigger. Optional, defaults to `false`.
function infoFormAbility(name, desc, descLong, cooldown, costMana, componentsInfo, costHP = 0, costIsPerc = false, 
isToggle = false, isHoldAndRelease = false) constructor {
  abilName = name;
  abilDesc = desc;
  abilDescLong = descLong;
  abilCooldown = cooldown;
  abilCostMana = costMana;
  abilCostHP = costHP;
  abilComponentInfo = componentsInfo;
  abilCostIsPerc = costIsPerc;
  abilIsToggle = isToggle;
  abilIsHoldAndRelease = isHoldAndRelease;
}

/// @desc Initiate SG Form Info
/// @returns {array<Struct.infoFormLine>} SG Form Info Array
function initFormInfo() {
	var sgFormData;
  sgFormData[countSGForms-1] = 0;
	
	for (var i = 0; i < countSGForms; i += 1) {
		sgFormData[i] = new infoFormLine(i);
  }

	dpFormsPlayer(sgFormData);
  return sgFormData;
}