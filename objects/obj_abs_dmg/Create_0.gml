dmgOnHitEffects = [];
dmgIntrinsicOnHitEffects = [];
dmgCategory = dmgSrcTypeEnum.sOther;
customData = {};
dmgIsStandardShot = false;

dmgVal = 0;
dmgEnemyHPScaleMax = 0;
dmgEnemyHPScaleCurr = 0;
dmgEnemyHPScaleMissing = 0;
dmgMult = 1;

customCodeStep = array_create(0, function(self) {});
customCodeDmg = array_create(0, function(self) {});
customCodeDestroy = array_create(0, function(self) {});
customCodeDraw = array_create(0, function(self) {});