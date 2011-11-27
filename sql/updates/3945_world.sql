UPDATE creature_template SET ScriptName = "npc_windsor_brd" WHERE entry = 9023;
UPDATE gameobject_template SET ScriptName = "windsor_jailbreak_door" WHERE entry IN (170561, 170562, 170568, 170569, 170567, 170566);
UPDATE creature_template SET faction_a = 11, faction_h = 11 WHERE entry = 9682;
UPDATE locales_quest SET EndText_loc2 = "Évasion !" WHERE entry = 4322;

DELETE FROM escort_waypoints WHERE entry = 9023;
INSERT INTO escort_waypoints (entry, pointid, location_x, location_y, location_z, waittime, point_comment) VALUES
(9023, 0, 320.271851, -213.937119, -78.049698, 0, ""),
(9023, 1, 285.543671, -180.047119, -76.054558, 0, ""),
(9023, 2, 267.862579, -149.283127, -72.578606, 0, ""),
(9023, 3, 279.637268, -117.664398, -70.515762, 0, ""),
(9023, 4, 289.463470, -90.046227, -76.328270, 0, ""),
(9023, 5, 287.063507, -87.676216, -76.683228, 2000, ""), -- devant la cellule de Dughal door 170562 - pause escort
(9023, 6, 303.712524, -77.746536, -77.846275, 0, ""),
(9023, 7, 356.203735, -60.305183, -67.489685, 0, ""),
(9023, 8, 398.285706, -68.003052, -63.094143, 0, ""),
(9023, 9, 402.751953, -63.590347, -63.440388, 2000, ""), -- devant l'entrepôt door 170561 - don't pause
(9023, 10, 408.694885, -49.901554, -63.962944, 5000, ""), -- dans l'entrepôt -> UpdateEntry(9682) - don't pause
(9023, 11, 403.393066, -64.001595, -63.435772, 0, ""), -- sortie
(9023, 12, 444.597992, -81.886475, -63.714592, 0, ""),
(9023, 13, 499.520996, -99.512054, -62.380878, 0, ""),
(9023, 14, 551.619202, -118.903595, -62.652931, 0, ""),
(9023, 15, 587.643921, -130.489563, -68.706856, 0, ""),
(9023, 16, 589.729004, -138.792755, -68.622177, 2000, ""), -- devant la 2e cellule, après la grande salle (I never liked those two) -> doivent attaquer door 170568
(9023, 17, 630.426575, -143.462204, -71.294289, 0, ""),
(9023, 18, 632.100769, -157.192520, -70.952393, 2000, ""), -- devant la 3e cellule - pause - door 170569
(9023, 19, 652.154114, -164.785049, -72.682838, 0, ""),
(9023, 20, 655.329651, -227.036255, -83.114555, 0, ""),
(9023, 21, 611.493164, -269.873962, -83.683342, 0, ""),
(9023, 22, 561.366638, -268.421021, -75.979668, 0, ""),
(9023, 23, 550.860107, -254.604492, -70.843536, 0, ""),
(9023, 24, 554.810242, -246.539703, -70.389420, 2000, ""), -- devant la 4e cellule - door 170567 - attack
(9023, 25, 553.023193, -274.419617, -74.986397, 2000, ""), -- devant la 5e cellule -> tobias - pause - door 170566
(9023, 26, 521.583313, -228.155685, -62.257145, 0, ""),
(9023, 27, 504.682434, -159.743408, -62.349358, 0, ""),
(9023, 28, 483.498474, -53.624634, -62.757809, 0, ""),
(9023, 29, 469.917023, -4.987278, -70.213585, 0, ""),
(9023, 30, 462.840393, 18.102631, -71.019333, 0, ""), -- setrun and complete quest
(9023, 31, 457.369110, 35.954590, -69.166763, 0, ""); -- end

DELETE FROM script_texts WHERE entry BETWEEN -1000799 AND -1000776;
INSERT INTO script_texts (entry, content_default, content_loc2, type, comment) VALUES
(-1000776, "Let's get a move on. My gear should be in the storage area up this way...", "Allons-y. Mon équipement devrait se trouver dans l'entrepôt là-bas...", 0, "WINDSOR_SAY_START"),
(-1000777, "Check that cell, $N. If someone is alive in there, we need to get them out.", "Vérifiez cette cellule, $N. Si quelqu'un est en vie là-dedans, nous devons l'en sortir.", 0, "WINDSOR_SAY_OPENDOOR"),
(-1000778, "Thank you, $N! I'm free!!!", "Merci, $N ! Je suis libre !!!", 1, "WINDSOR_SAY_DUGHAL"),
(-1000779, "Get him out of there!", "Sortez-le de là !", 0, "WINDSOR_SAY_FREEPRISONER"),
(-1000780, "Good work! We're almost there, $N. This way.", "Bon travail ! Nous y sommes presque, $N. Par ici.", 0, "WINDSOR_SAY_ALMOST_THERE"),
(-1000781, "This is it, $N. My stuff should be in that room. Cover me, I'm going in!", "C'est ici, $N. Mes affaires doivent être dans cette pièce. Couvrez-moi, j'entre !", 0, "WINDSOR_SAY_ENTER"),
(-1000782, "Can you feel the power, $N??? It's time to ROCK!", "Pouvez-vous sentir la puissance, $N ??? Ca va faire mal !", 1, "WINDSOR_SAY_ROCK"),
(-1000783, "Now we just have to free Tobias and we can get out of here. This way!", "Maintenant, il ne nous reste plus qu'à trouver Tobias et nous pouvons sortir d'ici. Par là !", 0, "WINDSOR_SAY_FIND_TOBIAS"),
(-1000784, "Open it.", "Ouvrez-la.", 0, "WINDSOR_SAY_OPEN_IT"),
(-1000785, "This is gonna leave a mark!", "Ca va laisser des marques !", 1, "WINDSOR_SAY_LEAVE_MARK"),
(-1000786, "I never did like those two. Let's get moving.", "Je n'ai jamais aimé ces deux-là. Continuons.", 0, "WINDSOR_SAY_NEVER_LIKED"),
(-1000787, "Open it and be careful this time!", "Ouvrez-la, et soyez prudent cette fois !", 0, "WINDSOR_OPEN_CAREFUL"),
(-1000788, "Perhaps Ograbisi will use your head as a tiny little hat when I'm through with you.", "Peut-être qu'Ograbisi utilisera votre tête comme un petit chapeau quand j'en aurai terminé avec vous.", 1, "WINDSOR_SAY_DINGER"),
(-1000789, "Administering fists of fury on Shill Dinger!", "Ressens les gifles de la fureur, Shill Dinger !", 1, "WINDSOR_SAY_ATTACK_DINGER"),
(-1000790, "That intolerant dirtbag finally got what was coming to him. Good riddance!", "Cet individu aura finalement obtenu ce qui l'attendait. Bon débarras !", 0, "WINDSOR_KILLED_DINGER"),
(-1000791, "Open it. We need to hurry up. I can smell those Dark Irons coming a mile away and I can tell you one thing, they're COMING!", "Ouvrez-la. Nous devons nous dépêcher. Je peux sentir ces Sombrefers arriver à un kilomètre et je peux vous dire une chose, ILS ARRIVENT !", 0, "WINDSOR_SAY_OPEN_HURRY"),
(-1000792, "Where I come from, you get shanked for opening another inmate's cell door!", "Dans le pays d'où je viens, vous vous faites tuer pour avoir ouvert la porte d'un compagnon de cellule !", 0, "WINDSOR_SAY_CREST"),
(-1000793, "Administering fists of fury on Crest Killer!", "Ressens les gifles de la fureur, Tueur des sommets !", 1, "WINDSOR_ATTACK_CREST"),
(-1000794, "He has to be in the last cell. Unless... they killed him.", "Il doit être dans la dernière cellule. A moins... qu'ils l'aient tué.", 0, "WINDSOR_SAY_KILLED_CREST"),
(-1000795, "Get him out of there!", "Sortez-le de là !", 0, "WINDSOR_SAY_OPEN_TOBIAS"),
(-1000796, "Finally!! I can leave this dump.", "Enfin !! Je peux quitter ce dépotoir !", 1, "WINDSOR_SAY_TOBIAS_FREE"),
(-1000797, "Excellent work, $N. Let's find the exit. I think I know the way. Follow me!", "Excellent travail, $N. Essayons de trouver une sortie. Je pense que je connais le chemin. Suivez-moi !", 0, "WINDSOR_SAY_CONGRATS"),
(-1000798, "We made it!", "Nous avons réussi !", 1, "WINDSOR_SAY_MADE_IT"),
(-1000799, "Meet me at Maxwell's encampment. We'll go over the next stages of the plan there and figure out a way to decode my tablets without the decryption ring.", "Retrouvez-moi au camp de Maxwell. Nous discuterons des prochaines étapes de notre plan et réfléchirons à un moyen de décoder mes tablettes sans l'anneau de décryptage.", 0, "WINDSOR_SAY_END");
