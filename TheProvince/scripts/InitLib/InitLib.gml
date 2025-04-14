function __loaderBase() constructor 
{
    static Process = function(_init) { return true; }
}

function LoaderSystem() : __loaderBase() constructor 
{
    static Process = function(_init) 
    {
        // create gamestate object
        // load system data
        // load persistent camera

        randomize();

        global.ChoicePool = [];
        global.ChoicePool = [
            new ChoiceData()
                .SetTitle("Merchant's Trade Deal")
                .SetDescription("Venerable Sir, I humbly beseech you to allow me to trade within your grand province.\nI have a fine selection of goods, and I am sure you will find them most agreeable.\n\nI am willing to pay a fair price for the privilege of trading here, however, I must mention that Lady Venn has \"subtly\" promised cheaper taxes for trading with her.\nNow I understand the farmers of your town might be displeased...slightly...However, I assure you that profits await!\n\nWhat say you, Sir?\n\n(People's Loyalty -1, and Gold +5) vs. (Nobles' Loyalty -1)")
                .AddConditionFunc( function() { return (!global.GameManager.GetWorldState().IsAtWar); })
                .AddAcceptCallback(function() 
                    { 
                        SetFlag("MerchantDeal"); 
                        global.GameManager.GetStats().Loyalty--; 
                        global.GameManager.AddDelayedCallback(function() 
                            {
                                global.GameManager.GetStats().AddToStat(StatType.GOLD, 5);
                            }
                        , 1);
                    }
                )
                .AddRejectCallback(function() { SetFlag("MerchantDeal", false); global.GameManager.GetStats().NobleLoyalty--; })
                .SetReappearDelay(5),
        
            new ChoiceData()
                .SetTitle("Food Shortage")
                .SetDescription("Sir, we have received reports of a food shortage in the province.\nThe farmers are complaining that they cannot grow enough food to feed the population.\n\nAn idea has been brought up by High Cleric Talve to send some of the soldiers into the woods to look for possible food sources.\nHowever, this may cause some unrest amongst the soldiers, as they are not trained to be foragers, nor are they trained to kill non-human entities.\n\nWhat say you, Sir?\n\n(People's Loyalty +1, Food +5, Army Strength -1, and Nobles' Loyalty -1) vs. (People's Loyalty -1, and Nobles' Loyalty +1)")
                .AddConditionFunc( function() { return (global.GameManager.GetStats().Food < 20); })
                .AddAcceptCallback(function() 
                    { 
                        SetFlag("FoodStocked"); 
                        global.GameManager.GetStats().Loyalty++; 
                        global.GameManager.AddDelayedCallback(function() 
                            {
                                global.GameManager.GetStats().AddToStat(StatType.FOOD, 5);
                            }
                        , 1);
                        global.GameManager.GetStats().ArmyStrength--;
                        global.GameManager.GetStats().NobleLoyalty--;
                    }
                )
                .AddRejectCallback(function() { SetFlag("FoodStocked", false); global.GameManager.GetStats().Loyalty--; global.GameManager.GetStats().NobleLoyalty++;}),
        
            new ChoiceData()
                .SetTitle("Disperse Protesters")
                .SetDescription("Good Morrow, we have received reports of a protest in the town square.\nThe farmers are protesting against the taxes imposed by Lady Venn.\n\nHigh Cleric Talve has suggested that we send some soldiers to disperse the protesters. The Soldiers under Marshal Dravik are eager to wet their blades.\nHowever, this may cause some unrest amongst the farmers. Lives may be lost...\n\nWhat say you, Sir?\n\n(People's Loyalty -1, Nobles' Loyalty +1, and Army Strength +5) vs. (People's Loyalty +1, and Nobles' Loyalty -1)")
                .AddConditionFunc( function() { return (global.GameManager.GetStats().Loyalty <= 5); })
                .AddAcceptCallback(function() 
                    { 
                        SetFlag("CurrentWorldMood", WorldMood.REBELLIOUS); 
                        global.GameManager.GetStats().Loyalty--; 
                        global.GameManager.GetStats().AddToStat(StatType.ARMY_STRENGTH, 2);
                        global.GameManager.GetStats().NobleLoyalty++;
                    }
                )
                .AddRejectCallback(function() { SetFlag("CurrentWorldMood", WorldMood.ANXIOUS); global.GameManager.GetStats().Loyalty++; global.GameManager.GetStats().NobleLoyalty--;}),
        
            new ChoiceData()
                .SetTitle("Fund a Local Festival")
                .SetDescription("Greetings, child. I, High Cleric Talve, have a proposal for you.\nThe farmers are unhappy with the taxes imposed by Lady Venn.\n\nI propose that we fund a local festival to boost morale and improve relations with the farmers.\nHowever, this will cost a significant amount of gold. I do decree that under our Lord, this festival is what is destined for us.\n\nWhat say you, Sir? Does the Lord speak through you?\n\n(People's Loyalty +1, Nobles' Loyalty +1, and Gold -10) vs. (Nobles' Loyalty -1 and People's Loyalty -1)")
                .AddAcceptCallback(function() 
                    { 
                        SetFlag("FestivalFunded"); 
                        global.GameManager.GetStats().Loyalty++; 
                        global.GameManager.GetStats().AddToStat(StatType.GOLD, -10);
                        global.GameManager.AddDelayedCallback(function() {global.GameManager.GetStats().NobleLoyalty++;}, 1);
                    }
                )
                .AddRejectCallback(function() { SetFlag("FestivalFunded", false); global.GameManager.GetStats().Loyalty--; global.GameManager.GetStats().NobleLoyalty--; }),
        
            new ChoiceData()
                .SetTitle("Cult Rumors")
                .SetDescription("Peasants have been whispering about a cult that has been spreading rumors of a great evil in the woods.\nThey say that the cult is trying to summon a great evil to destroy the province.\n\nHigh Cleric Talve has suggested that we send some soldiers to investigate the rumors. However, this may cause some unrest amongst the peasants who have sided with the cult. Marshal Dravik seems eager...\n\nWhat say you, Sir?\n\n(People's Loyalty -1, Nobles' Loyalty +1, and Army Strength +2) vs. (People's Loyalty +1, and Nobles' Loyalty -1)")
                .AddAcceptCallback(function() 
                    { 
                        SetFlag("DestroyCult"); 
                        global.GameManager.GetStats().Loyalty--; 
                        global.GameManager.GetStats().AddToStat(StatType.ARMY_STRENGTH, 2);
                        global.GameManager.GetStats().NobleLoyalty++;
                    }
                )
                .AddRejectCallback(function() { SetFlag("DestroyCult", false); global.GameManager.GetStats().Loyalty++; global.GameManager.GetStats().NobleLoyalty--; }),
        
            new ChoiceData()
                .SetTitle("Council Ultimatum")
                .SetDescription("My good man, you have rejected the words of your own council of Nobles for far too long.\nLady Venn has been most displeased with your lack of action, and Marshal Dravik wishes for war.\n\nThey have given you an ultimatum: either you accept their leadership and guidance to tax the farmers, or they will take matters into their own hands.\n\nWhat say you?\n\n(Nobles' Loyalty +1 and No War) vs. (Nobles' Loyalty -1 and War)")
                .AddConditionFunc( function() { return (global.GameManager.GetStats().NobleLoyalty <= 2); })
                .AddRejectCallback(function() 
                    { 
                        SetFlag("WarWithNobles"); 
                        global.GameManager.GetStats().NobleLoyalty--; 
                        global.GameManager.GetWorldState().IsAtWar = true;
        
                    }
                )
                .AddAcceptCallback(function() { SetFlag("WarWithNobles", false); global.GameManager.GetStats().NobleLoyalty++; global.GameManager.GetWorldState().IsAtWar = false;}),
        
            new ChoiceData()
                .SetTitle("War with the Nobles")
                .SetDescription("The Nobles have sent the army against you. Sadly, you are alone in this fight. The farmers, disgusted with your rule, have sided with the Nobles.\n\nYou have no choice but to fight. The Nobles are marching towards the castle, and they will not stop until you are dead.\n\nWill you surrender your control?\n\n")
                .AddConditionFunc( function() { return (global.GameManager.GetWorldState().IsAtWar and global.GameManager.GetWorldState()[$ "WarWithNobles"] and global.GameManager.GetStats().Loyalty <= 3); })
                .AddAcceptCallback(function() 
                    { 
                        global.vars.SetLoseReason(LoseReason.NOBLE_SURRENDER)
                        Transition(rmLose, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
                    }
                )
                .AddRejectCallback(function() { 
                    global.vars.SetLoseReason(LoseReason.KILLED)
                    Transition(rmLose, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
                }), 
        
            new ChoiceData()
                .SetTitle("War with the Nobles")
                .SetDescription("The Nobles have sent the army against you. Luckily, the farmers seem to be on your side. You can either fight with the farmers or surrender.\n\nWill you fight?\n\n(People's Loyalty +1, and Nobles' Death) vs. (Your Defeat)")
                .AddConditionFunc( function() { return (global.GameManager.GetWorldState().IsAtWar and global.GameManager.GetWorldState()[$ "WarWithNobles"] and global.GameManager.GetStats().Loyalty <= 3); })
                .AddAcceptCallback(function() 
                    { 
                        global.GameManager.GetWorldState().IsAtWar = false;
                        global.GameManager.GetStats().Loyalty++;
                        global.GameManager.AddDelayedCallback(function() {
                            if (global.GameManager.GetStats().Loyalty <= global.GameManager.GetStats().ArmyStrength) {
                                global.vars.SetLoseReason(LoseReason.KILLED)
                                Transition(rmLose, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
                            }
                            else
                            {
                                SetFlag("DefeatedNobles");
                                global.GameManager.GetStats().Loyalty++;
                            }
                        }, 1);
                    }
                )
                .AddRejectCallback(function() { 
                    global.vars.SetLoseReason(LoseReason.KILLED)
                    Transition(rmLose, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
                }),  
                
            new ChoiceData()
                .SetTitle("Farmer's Rebellion")
                .SetDescription("The farmers have rebelled against you. They are angry about the taxes imposed by Lady Venn.\n\nYou can either fight with the Nobles or surrender.\n\nWill you fight?\n\n(People's Loyalty -1, and Nobles' Loyalty +1) vs. (Your Defeat)")
                .AddConditionFunc( function() { return (global.GameManager.GetStats().Loyalty <= 1); })
                .AddAcceptCallback(function() 
                    { 
                        global.GameManager.GetWorldState().IsAtWar = true;
                        global.GameManager.AddDelayedCallback(function() {
                            if (global.GameManager.GetStats().Loyalty >= global.GameManager.GetStats().ArmyStrength) {
                                global.vars.SetLoseReason(LoseReason.KILLED)
                                Transition(rmLose, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
                            }
                            else
                            {
                                SetFlag("DefeatedFarmers");
                                global.GameManager.GetStats().NobleLoyalty++;
                            }
                        }, 1);
                    }
                )
                .AddRejectCallback(function() { 
                    global.vars.SetLoseReason(LoseReason.FARMER_SURRENDER)
                    Transition(rmLose, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
                }),
        
            new ChoiceData()
                .SetTitle("Grain Storage Decision")
                .SetDescription("Your granaries overflow. You can sell to neighboring lords for gold, or you can store it for the winter. Selling the food might also make our enemies stronger, but keeping the food might make the King irritated. He frequently pushes us to share...\n\nWhat say you?\n\n(People's Loyalty -1, and Gold +10) vs. (People's Loyalty +1, and King's Anger)")
                .AddConditionFunc( function() { return (global.GameManager.GetStats().Food > 10); })
                .AddAcceptCallback(function() 
                    { 
                        SetFlag("EnemiesFed"); 
                        global.GameManager.GetStats().Loyalty--; 
                        global.GameManager.GetStats().AddToStat(StatType.GOLD, 10);
                    }
                )
                .AddRejectCallback(function() 
                    { 
                        SetFlag("KingAngered"); 
                        global.GameManager.GetStats().Loyalty++; 
                         
                    }
                ),
        
            new ChoiceData()
                .SetTitle("Spy Network")
                .SetDescription("Marshal Dravik has suggested that we establish a spy network to gather information about the neighboring provinces.\nThis will cost a significant amount of gold, but it may provide valuable intel.\n\nWhat say you, Sir?\n\n(Intel +5, and Gold -10, Nobles' Loyalty +1) vs. (Nobles' Loyalty -1)")
                .AddAcceptCallback(function() 
                    { 
                        SetFlag("SpyNetwork"); 
                        global.GameManager.GetStats().AddToStat(StatType.GOLD, -10);
                        global.GameManager.GetStats().AddToStat(StatType.INTEL, 5);
                        global.GameManager.GetStats().NobleLoyalty++;
                    }
                )
                .AddRejectCallback(
                    function() 
                    { 
                        global.GameManager.GetStats().NobleLoyalty--; 
                    }
                ),
        ];

        global.GameManager = noone;
        global.DocumentSpawner = noone;

        instance_create_depth(0, 0, -1600, obj_Mouse);
        global.textDisplay = "\"[c_yellowPalette]These creatures that walk in your footsteps...they have no hope, save you...[/]\"";
        global.textDisplay = string_concat(global.textDisplay, "[c_parchment], your father's voice croaks...\n\n[/]");
        global.textDisplay = string_concat(global.textDisplay, "\"[c_yellowPalette]They cling to you like the seeds of a thorn-bush...[/]\"\n\n");
        global.textDisplay = string_concat(global.textDisplay, "[c_parchment]The sounds of your father coughing echo amongst the rotting wood...[/]\n\n");
        global.textDisplay = string_concat(global.textDisplay, "\"[c_yellowPalette]You must lead them unto salvation, my child...[/]\"\n\n\n");
        global.textDisplay = string_concat(global.textDisplay, "\"[c_lighterPurple]What is this salvation you speak of, father? Where does it lie?[/]\"\n\n\n");
        global.textDisplay = string_concat(global.textDisplay, "\"[c_yellowPalette]...[/]\"\n\n\n");
        
        return true;
    }    
}

function LoaderAssets() : __loaderBase() constructor 
{
    static Process = function(_init) 
    {
        // load assets
        // load fonts
        // load sprites
        // load sounds
        // load shaders
        

        get_perlin_noise_buffer();
        return true;
    }    
}

function LoaderGameData() : __loaderBase() constructor 
{
    static Process = function(_init) 
    {
        // load game data
        // load levels
        // load objects

        return true;
    }    
}