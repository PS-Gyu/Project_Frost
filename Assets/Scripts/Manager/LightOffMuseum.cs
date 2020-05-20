using Invector.vCamera;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;

public class LightOffMuseum : MonoBehaviour
{
    DialogueManager theDM;
    // Start is called before the first frame update
    void Start()
    {
        DarkMusFirst.firstDial = false;
        DarkMusSec.secDial = false;
        DarkMusThird.thirdDial = false;
        theDM = FindObjectOfType<DialogueManager>();
        StartCoroutine(lightOffMuseum());
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    IEnumerator lightOffMuseum()
    {
        yield return new WaitForSeconds(2.0f);
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 1;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 6;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;

        yield return new WaitUntil(() => DarkMusFirst.firstDial);
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 7;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 19;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;

        yield return new WaitUntil(() => DarkMusSec.secDial);
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 20;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 22;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;

        yield return new WaitUntil(() => DarkMusThird.thirdDial);
        gameObject.GetComponent<PlayableDirector>().gameObject.SetActive(true);

        /*DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 23;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 29;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;
        */

        yield return null;
    }
}
