using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InteractionEvent : MonoBehaviour
{
    [SerializeField] public DialogueEvent dialogue;
    [SerializeField] public bool isFirst = true;
    
    public Dialogue[] GetDialogue()
    {
        dialogue.dialogues = DatabaseManager.instance.GetDialogue((int)dialogue.line.x, (int)dialogue.line.y);
        return dialogue.dialogues;
    }
}
