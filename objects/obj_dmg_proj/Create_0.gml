event_inherited();
dmgCategory = dmgSrcTypeEnum.sProj;

projOwner = -1;
projDmgVal = 0;
projDmgType = dmgProjTypeEnum.projOther;
projDmgResHit = dmgResHitTypeEnum.pViral;
projDmgElem = elementTypes.eNone;
projDmgMult = 1;
projDmgEnemyHPScaleCurr = 0;
projDmgEnemyHPScaleMax = 0;
projDmgEnemyHPScaleMiss = 0;
projLS = 0;

projSpdBase = 1;
projSpdCurr = 1;
projDir = 0;
projAcc = 0;
projPierceMax = 0;
projPierceCurr = 0;
projPierceDeg = 1;
projDist = 0;

projSizeX = 1;
projSizeY = 1;
projSprRotDir = true;
projSpr = spr_proj_ss_fire;
projCol = c_white;
projAlpha = 1;
projSideLength = 0;
projCanApplyOnHit = true;

projOOB = 120;

xPrev = x;
yPrev = y;
dirPrev = 0;
collList = ds_list_create();
lifeCollMap = ds_map_create();
lifeCollMax = 1;

projCodeCreate = function(self) {};
projCodeStep = function(self) {};
projCodeDmg = function(self, other) {};
projCodeDestroy = function(self) {};
projCodeDraw = function(self) {};

setDeletion = false;