using Invector.vCharacterController;
using Invector.vCharacterController.vActions;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Street : MonoBehaviour
{
    [SerializeField] Camera streetCam;
    [SerializeField] Camera mainCam;
    DialogueManager theDM;


    // Start is called before the first frame update
    void Start()
    {
        theDM = FindObjectOfType<DialogueManager>();
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonController>().enabled = false;
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonInput>().enabled = false;
        GameObject.FindWithTag("Player").GetComponent<vGenericAction>().enabled = false;
        streetCam.gameObject.SetActive(true);
        StartCoroutine(StreetCoroutine());
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    IEnumerator StreetCoroutine()
    {
        yield return new WaitForSeconds(1.0f);
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 1;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 3;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());

        yield return new WaitForSeconds(8.5f);
        streetCam.gameObject.SetActive(false);
        mainCam.gameObject.SetActive(true);
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonController>().enabled = true;
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonInput>().enabled = true;
        GameObject.FindWithTag("Player").GetComponent<vGenericAction>().enabled = true;
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;

        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 4;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 28;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;

        yield return new WaitUntil(() => DarkMusFirst.firstDial);
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 29;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 36;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;

        yield return new WaitUntil(() => DarkMusSec.secDial);
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 37;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 43;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;

        yield return null;
    }
}
