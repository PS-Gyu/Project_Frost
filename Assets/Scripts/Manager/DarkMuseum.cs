using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DarkMuseum : MonoBehaviour
{
    DialogueManager theDM;
    // Start is called before the first frame update
    void Start()
    {
        theDM = FindObjectOfType<DialogueManager>();
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 1;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 1;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        DialogueManager.isRealEnd = false;
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
