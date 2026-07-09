event_inherited();
dmgCategory = dmgSrcTypeEnum.sExpl;

explOwner = -1;
explType = dmgExplShapeEnum.explRound;
explDmgType = dmgExplTypeEnum.explBoom;
explDmgResHit = dmgResHitTypeEnum.eAtt;
explDmgElem = elementTypes.eNone;
explDmgEdgeMult = 1;
explApplyOnHit = false;

explSpr = spr_dmg_gen_expl;
explColA = #FFFFFF;
explColB = #888888;
explColC = #000000;
explColCurr = explColA;
explAlphaCurr = 1;
explMaxScaleX = 1;
explMaxScaleY = 1;
explRadiusNum = 0;
explScaleCurr = 0;

explDir = 0;
explConeW = 0;
explRectW = 0;
explRectH = 0;

explTimer = 0;
explTimePerc = 0;
explDur = 30;

explCodeCreate = function(self) {};
explCodeStep = function(self) {};
explCodeDmg = function(self, other) {};
explCodeDestroy = function(self) {};

collCount = 0;
collListExpl = ds_list_create();
collCheck = obj_abs_entity;
explMultiPartsOwner = -1;