class DRCustomActor extends Actor;

var string nameCharacter;
var int baseAttackValue;
var bool NPC;
var () string msgEditable;

const warriorBonus = 2.5;

//PostBeginPlay() will be called after all other Actors have been initialized
event PostBeginPlay() 
{
    DrawDebugSphere(self.Location, 30.0f, 20, 255, 0 , 0 , true);
    
    Super.PostBeginPlay();
    
    /*float damage;
    int num1, num2;

    damage = calculateDamage(125,15);
    `log( "Damage Received: " $ damage);
    
	createTwoRandom(num1, num2);
	`log( "1st Number created : " $ num1);
	`log( "2nd Number created : " $ num2);
	*/
}

function float calculatePowerAttack()
{
	local float powerAttack;
	powerAttack = baseAttackValue * warriorBonus;
	return powerAttack;
}

function float calculateDamage(float powerAttack, int defenseLevel)
{
	return (powerAttack * 10) / defenseLevel;
}

function createTwoRandom(out int number1, out int number2, optional int maxValue = 10)
{
	number1 = Rand(maxValue);
	number2 = Rand(maxValue);
}

//The word "auto" defines the initial State
auto state Roaming
{
  function moveAI(float DeltaTime)
  {
    //move randomly
    //If player is near:
    //  GotoState('Chasing');
  }
} 
state Chasing
{
  function moveAI(float DeltaTime)
  {
    //move towards player
  }
}
state Fleeing
{
  function moveAI(float DeltaTime)
  {
    //move away from the player
  }
}

defaultproperties
{
	nameCharacter = "paytheo"
	baseAttackValue = 50
	NPC = false
}