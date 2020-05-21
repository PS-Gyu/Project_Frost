using Invector.vCharacterController;
using Invector.vCharacterController.vActions;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MuseumBase : MonoBehaviour
{
    [SerializeField] Camera baseCam;
    [SerializeField] Camera mainCam;
    DialogueManager theDM;
    // Start is called before the first frame update
    void Start()
    {
        theDM = FindObjectOfType<DialogueManager>();
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonController>().enabled = false;
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonInput>().enabled = false;
        GameObject.FindWithTag("Player").GetComponent<vGenericAction>().enabled = false;
        baseCam.gameObject.SetActive(true);
        StartCoroutine(BaseCoroutine());
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    IEnumerator BaseCoroutine()
    {
        yield return new WaitForSeconds(1.0f);
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 1;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 2;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());

        yield return new WaitForSeconds(8.5f);
        baseCam.gameObject.SetActive(false);
        mainCam.gameObject.SetActive(true);
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonController>().enabled = true;
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonInput>().enabled = true;
        GameObject.FindWithTag("Player").GetComponent<vGenericAction>().enabled = true;



        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;

        yield return null;
    }
}
