event_inherited();
dmgCategory = dmgSrcTypeEnum.sAura;

auraOwner = -1;
auraDmgVal = 0;
auraDmgResHit = dmgResHitTypeEnum.eAtt;
auraDmgElem = elementTypes.eNone;
auraDmgMult = 1;
auraDmgEdgeMult = 1;
auraApplyOnHit = false;
auraDmgEnemyHPScaleCurr = 0;
auraDmgEnemyHPScaleMax = 0;
auraDmgEnemyHPScaleMiss = 0;

auraAttachObj = -1;
auraAttachOffsetX = 0;
auraAttachOffsetY = 0;

auraSpr = spr_aura;
auraCol = #FFFFFF;
auraAlphaCurr = 1;
auraScale = 1;
auraRadiusNum = 0;

auraTimer = 0;
auraTimePerc = 0;
auraTickInterval = 15; //Collide every X frames, 15 = 4/s
auraDur = 30;

auraShipForm = -1;

auraCodeCreate = function(self) {};
auraCodeStep = function(self) {};
auraCodeDmg = function(self, other) {};
auraCodeDestroy = function(self) {};

auraCollList = ds_list_create();
auraCollCount = 0;
collCheck = obj_abs_entity;