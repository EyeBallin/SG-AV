projOwner = -1;
projShipForm = -1;
projDmgVal = 0;
projDmgType = dmgProjTypeEnum.projOther;
projDmgResHit = dmgResHitTypeEnum.pViral;
projDmgElem = elementTypes.eNone;
projDmgMult = 1;
projDmgPhys = 0;
projDmgEner = 0;
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

projOOB = 120;

projEffects = [];

xPrev = x;
yPrev = y;
dirPrev = 0;
collList = ds_list_create();
lifeCollMap = ds_map_create();
lifeCollMax = 1;

projCodeCreate = function() {};
projCodeStep = function() {};
projCodeDmg = function() {};
projCodeDestroy = function() {};

setDeletion = false;