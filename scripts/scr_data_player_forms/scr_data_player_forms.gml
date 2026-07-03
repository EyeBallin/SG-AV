/// @desc Fill out SG Form Data (Standard Shots, Abilities, Stats, etc.)
/// @param {array<Struct.infoFormLine>} sgFormData Array of form info lines
/// @return {array<Struct.infoFormLine>} Filled-out form data
function dpFormsPlayer(sgFormData) {
	var allSpd = 12; //Temporary, probably?
	
	//Fire
    addFormInfo(sgFormData[sgForm.formFire], #FF0000, "Fire Form", 
        "Deals decently strong mixed damage through a variety of means, but has low range standard shots.", projIDEnum.ssFire,
        new infoFormLineStats(
            100, 110, 10, 10,                                 //HP, Mana, HP Regen, Mana Regen
            9, allSpd,                                        //Attack Speed, Movespeed
            20, 15,                                           //Collision Resistance, Projectile Resistance
            0.25, 0, 0, -0.25, 0, 0, elementTypes.eFire,      //Fire/Elec/Psn/Ice/Light/Dark Resistance, Form Element
            0, 0                                              //Attack-Type/Spell-Type Damage Lifesteal
        )
    );
    
    //TODO: ADD SS CODE TO ALL FORMS
    //TODO: REMOVE DMG INFO FROM PROJ DATA
    //TODO: TEST THAT NEW ATT INFO STUFF WORKS
    
    //Fire - Fireball
    var formFireQName = getString("formFireQName");
    var formFireQDesc = getString("formFireQDesc");
    var formFireQDescLong = getString("formFireQDescLong");
    
    var formFireQStatScaling = new infoStatScaling(0.7, 0.8);
	var formFireQCompDmg = new infoAttackComponent(formFireQName, 150, formFireQStatScaling, attackDmgTypeEnum.typeSGSpell, elementTypes.eFire);
    
    var formStruct = sgFormData[sgForm.formFire];
    var abilInfo = new infoFormAbility(formFireQName, formFireQDesc, formFireQDescLong, 3, 15, [formFireQCompDmg]);
	formStruct.formQInfo = abilInfo;
	formStruct.formQCode = function(shipEnt, abilInfo) {
		var fireballProj = createProjectilePlayer(shipEnt.x, shipEnt.y-60, projIDEnum.spFireFireball, abilInfo.abilComponentInfo[0]);
	}
    
    //Fire - Signal Flares
    var formFireWName = getString("formFireWName");
    var formFireWDesc = getString("formFireWDesc");
    var formFireWDescLong = getString("formFireWDescLong");
    var formFireWScaling = new infoStatScaling(formFireWName, 0.15, 0.2);
    sgFormData[sgForm.formFire].formWInfo = new infoFormAbility(formFireWName, formFireWDesc, formFireWDescLong, 8, 40,
        formFireWScaling);
	sgFormData[sgForm.formFire].formWCode = function(shipEnt) {
		applyStatusEffect(shipEnt, shipEnt, statusEffects.bAblFireSignalFlares, 1, 1);
	}
    
    //Fire - Heat Wave
    sgFormData[sgForm.formFire].formECode = function(shipEnt) {
        var fireEAura = createAuraPlayer(shipEnt.x, shipEnt.y, auraIDEnum.auFireE, {
            auraDataFollowObj: shipEnt
        });
        fireEAura.auraCodeDestroy = function(fireEAura) {
            var fireEBoom = createExplosionPlayer(fireEAura.x, fireEAura.y, explIDEnum.sgFireE);
            array_push(fireEBoom.dmgIntrinsicOnHitEffects, new onHitEffect(onHitIDs.ohFireEKnockback));
        }
    }
    	
	//Electric
	addFormInfo(sgFormData[sgForm.formElec], #FFFF00, "Electric Form", 
        "Damages and disables sparse groups of enemies, and has occasional single-target burst.", projIDEnum.ssElec,
        new infoFormLineStats(
            100, 110, 10, 10,                                 //HP, Mana, HP Regen, Mana Regen
            7, allSpd,                                        //Attack Speed, Movespeed
            15, 20,                                           //Collision Resistance, Projectile Resistance
            0, 0.25, -0.25, 0, 0, 0, elementTypes.eElec,      //Fire/Elec/Psn/Ice/Light/Dark Resistance, Form Element
            0, 0                                              //Attack-Type/Spell-Type Damage Lifesteal
        )
    );
		
	//Poison
	addFormInfo(sgFormData[sgForm.formPsn], #00FF00, "Poison Form",
        "Spreads heavily-damaging and crippling toxins with fire-and-forget abilities.", projIDEnum.ssPsn,
        new infoFormLineStats(
            110, 100, 10, 10,                                 //HP, Mana, HP Regen, Mana Regen
            5, allSpd,                                        //Attack Speed, Movespeed
            15, 15,                                           //Collision Resistance, Projectile Resistance
            0, -0.25, 0.25, 0, 0, 0, elementTypes.ePsn,       //Fire/Elec/Psn/Ice/Light/Dark Resistance, Form Element
            0, 0                                              //Attack-Type/Spell-Type Damage Lifesteal
        )
    );
		
	//Ice
	addFormInfo(sgFormData[sgForm.formIce], #00FFFF, "Ice Form",
        "Specialises in defensive lockdown and area denial, but can potentially deal decent elemental damage.", projIDEnum.ssIce,
        new infoFormLineStats(
            110, 100, 10, 10,                                  //HP, Mana, HP Regen, Mana Regen
            6, allSpd,                                         //Attack Speed, Movespeed
            20, 20,                                            //Collision Resistance, Projectile Resistance
            -0.25, 0, 0, 0.25, 0, 0, elementTypes.eIce,        //Fire/Elec/Psn/Ice/Light/Dark Resistance, Form Element
            0, 0                                               //Attack-Type/Spell-Type Damage Lifesteal
        )
    );
		
	//Light
	addFormInfo(sgFormData[sgForm.formLight], #FFFFFF, "Light Form",
        "Can deal extreme on-hit damage with its rapid-fire passively doubled standard shots.", projIDEnum.ssLight,
        new infoFormLineStats(
            85, 115, 10, 10,                                    //HP, Mana, HP Regen, Mana Regen
            10, allSpd,                                         //Attack Speed, Movespeed
            10, 25,                                             //Collision Resistance, Projectile Resistance
            0, 0, 0, 0, 0.25, -0.25, elementTypes.eLight,       //Fire/Elec/Psn/Ice/Light/Dark Resistance, Form Element
            0, 0                                                //Attack-Type/Spell-Type Damage Lifesteal
        )
    );
		
	//Dark
	addFormInfo(sgFormData[sgForm.formDark], #000000, "Dark Form",
        "Slowly uses its Standard Shots and abilities in tandem to deal very high area damage.", projIDEnum.ssDark,
        new infoFormLineStats(
            110, 110, 10, 20,                                   //HP, Mana, HP Regen, Mana Regen
            4, allSpd,                                          //Attack Speed, Movespeed
            25, 10,                                             //Collision Resistance, Projectile Resistance
            0, 0, 0, 0, -0.25, 0.25, elementTypes.eDark,        //Fire/Elec/Psn/Ice/Light/Dark Resistance, Form Element
            0, 0                                                //Attack-Type/Spell-Type Damage Lifesteal
        )
    );
	
	//Siege
	addFormInfo(sgFormData[sgForm.formSiege], #FF00FF, "Siege Form",
        "Ramps up over time to unleash a deluge of strong but inaccurate Standard Shots.", projIDEnum.ssSiege,
        new infoFormLineStats(
            110, 90, 10, 10,                                    //HP, Mana, HP Regen, Mana Regen
            12, allSpd,                                         //Attack Speed, Movespeed
            30, 5,                                              //Collision Resistance, Projectile Resistance
            0, 0, 0, 0, 0, 0, elementTypes.eNone,               //Fire/Elec/Psn/Ice/Light/Dark Resistance, Form Element
            0, 0                                                //Attack-Type/Spell-Type Damage Lifesteal
        )
    );

	//Power
	addFormInfo(sgFormData[sgForm.formPower], #0000FF, "Power Form",
        "Slowly fires extremely strong standard shots. Very good at dealing damage in a straight line.", projIDEnum.ssPower,
        new infoFormLineStats(
            90, 120, 10, 10,                                    //HP, Mana, HP Regen, Mana Regen
            1.5, allSpd,                                        //Attack Speed, Movespeed
            5, 30,                                              //Collision Resistance, Projectile Resistance
            0, 0, 0, 0, 0, 0, elementTypes.eNone,               //Fire/Elec/Psn/Ice/Light/Dark Resistance, Form Element
            0, 0                                                //Attack-Type/Spell-Type Damage Lifesteal
        )
    );
    
    return sgFormData;
}