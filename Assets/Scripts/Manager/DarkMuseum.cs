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
        StartCoroutine(darkMuseum());
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    IEnumerator darkMuseum()
    {
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 34;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 34;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        DialogueManager.isRealEnd = false;
        yield return null;
    }
}
