explOwner = -1;
explType = dmgExplShapeEnum.explRound;
explDmgVal = 0;
explDmgPhys = 0;
explDmgEner = 0;
explDmgType = dmgExplTypeEnum.explBoom;
explDmgResHit = dmgResHitTypeEnum.eAtt;
explDmgElem = elementTypes.eNone;
explDmgEdgeMult = 1;

explSpr = spr_dmg_gen_expl;
explColA = #FFFFFF;
explColB = #888888;
explColC = #000000;
explColCurr = explColA;
explAlphaCurr = 1;
explMaxScaleX = 1;
explMaxScaleY = 1;
explScaleCurr = 0;

explTimer = 0;
explTimePerc = 0;
explDur = 30;

explShipForm = -1;

explCodeCreate = function() {};
explCodeStep = function() {};
explCodeDmg = function() {};
explCodeDestroy = function() {};