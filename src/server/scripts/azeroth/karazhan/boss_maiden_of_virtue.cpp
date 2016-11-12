/* Copyright (C) 2006 - 2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

/* ScriptData
SDName: Boss_Maiden_of_Virtue
SD%Complete: 100
SDComment:
SDCategory: Karazhan
EndScriptData */


#include "def_karazhan.h"

#define SAY_AGGRO               -1532018
#define SAY_SLAY1               -1532019
#define SAY_SLAY2               -1532020
#define SAY_SLAY3               -1532021
#define SAY_REPENTANCE1         -1532022
#define SAY_REPENTANCE2         -1532023
#define SAY_DEATH               -1532024

#define SPELL_REPENTANCE        29511
#define SPELL_HOLYFIRE          29522
#define SPELL_HOLYWRATH         32445
#define SPELL_HOLYGROUND        29512
#define SPELL_BERSERK           26662

struct boss_maiden_of_virtueAI : public ScriptedAI
{
    boss_maiden_of_virtueAI(Creature *c) : ScriptedAI(c) 
    {
        pInstance = ((InstanceScript*)c->GetInstanceScript());
    }

    InstanceScript *pInstance;

    uint32 Repentance_Timer;
    uint32 Holyfire_Timer;
    uint32 Holywrath_Timer;
    uint32 Holyground_Timer;
    uint32 Enrage_Timer;

    bool Enraged;

    void Reset()
    override {
        Repentance_Timer    = 20000;
        Holyfire_Timer      = 8000+(rand()%17000);
        Holywrath_Timer     = 20000;
        Holyground_Timer    = 3000;
        Enrage_Timer        = 600000;

        Enraged = false;

        if(pInstance)
            pInstance->SetData(DATA_MAIDENOFVIRTUE_EVENT, NOT_STARTED);
    }

    void KilledUnit(Unit* Victim)
    override {
        if(rand()%2)
            return;

        switch(rand()%3)
        {
        case 0: DoScriptText(SAY_SLAY1, me);break;
        case 1: DoScriptText(SAY_SLAY2, me);break;
        case 2: DoScriptText(SAY_SLAY3, me);break;
        }
    }

    void JustDied(Unit* Killer)
    override {
        DoScriptText(SAY_DEATH, me);

        if(pInstance)
            pInstance->SetData(DATA_MAIDENOFVIRTUE_EVENT, DONE);
    }

    void EnterCombat(Unit *who)
    override {
         DoScriptText(SAY_AGGRO, me);

         if(pInstance)
            pInstance->SetData(DATA_MAIDENOFVIRTUE_EVENT, IN_PROGRESS);
    }

    void UpdateAI(const uint32 diff)
    override {
        if (!UpdateVictim() )
            return;

        if (Enrage_Timer < diff && !Enraged)
        {
            DoCast(me, SPELL_BERSERK,true);
            Enraged = true;
        }else Enrage_Timer -=diff;

        if (Holyground_Timer < diff)
        {
            DoCast(me, SPELL_HOLYGROUND, true);     //Triggered so it doesn't interrupt her at all
            Holyground_Timer = 3000;
        }else Holyground_Timer -= diff;

        if (Repentance_Timer < diff)
        {
            DoCast(me->GetVictim(),SPELL_REPENTANCE);

            DoScriptText(rand()%2 ? SAY_REPENTANCE1 : SAY_REPENTANCE2, me);
            Repentance_Timer = 15000 + rand()%10000;
        }else Repentance_Timer -= diff;

        if (Holyfire_Timer < diff)
        {
            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM,0,80.0f,true,true,false,SPELL_REPENTANCE,1)) //don't select target with repentance
                DoCast(target,SPELL_HOLYFIRE);

                Holyfire_Timer = 8000 + rand()%17000; //Anywhere from 8 to 25 seconds, good luck having several of those in a row!
        }else Holyfire_Timer -= diff;

        if (Holywrath_Timer < diff)
        {
            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM,0))
                DoCast(target,SPELL_HOLYWRATH);

            Holywrath_Timer = 20000;

        }else Holywrath_Timer -= diff;

        DoMeleeAttackIfReady();
    }

};

CreatureAI* GetAI_boss_maiden_of_virtue(Creature *_Creature)
{
    return new boss_maiden_of_virtueAI (_Creature);
}

void AddSC_boss_maiden_of_virtue()
{
    OLDScript *newscript;
    newscript = new OLDScript;
    newscript->Name="boss_maiden_of_virtue";
    newscript->GetAI = &GetAI_boss_maiden_of_virtue;
    sScriptMgr->RegisterOLDScript(newscript);
}

