using Invector;
using Invector.vCamera;
using Invector.vCharacterController;
using Invector.vCharacterController.vActions;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.SceneManagement;

public class MuseumBase : MonoBehaviour
{
    [SerializeField] Camera baseCam;
    [SerializeField] Camera evCam;
    [SerializeField] Camera mainCam;
    [SerializeField] GameObject alert;
    [SerializeField] GameObject EV;
    [SerializeField] GameObject EVPlayer;
    DialogueManager theDM;
    int num = 0;
    // Start is called before the first frame update
    void Start()
    {
        DarkMusFirst.firstDial = false;
        DarkMusSec.secDial = false;
        DarkMusThird.thirdDial = false;
        BaseFourthDial.fourthDial = false;
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
        //mainCam.gameObject.SetActive(true);
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonController>().enabled = true;
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonInput>().enabled = true;
        GameObject.FindWithTag("Player").GetComponent<vGenericAction>().enabled = true;
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;

        yield return new WaitForSeconds(2.0f);
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 3;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 11;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;

        yield return new WaitUntil(() => DarkMusFirst.firstDial);
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 12;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 16;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;

        yield return new WaitUntil(() => DarkMusSec.secDial);
        yield return new WaitForSeconds(3.0f);
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 17;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 19;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;

        yield return new WaitForSeconds(4.0f);
        alert.SetActive(true);
        yield return new WaitForSeconds(2.0f);
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 20;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 27;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;

        yield return new WaitUntil(() => DarkMusThird.thirdDial);
        evCam.gameObject.SetActive(true);
        EV.GetComponent<PlayableDirector>().enabled = true;
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonController>().enabled = false;
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonInput>().enabled = false;
        GameObject.FindWithTag("Player").GetComponent<vGenericAction>().enabled = false;
        EVPlayer.transform.SetPositionAndRotation(GameObject.FindWithTag("Player").GetComponent<Transform>().position, GameObject.FindWithTag("Player").GetComponent<Transform>().rotation);
        yield return new WaitForSeconds(10.5f);
        evCam.gameObject.SetActive(false);
        GameObject.FindWithTag("Player").transform.SetPositionAndRotation(EVPlayer.transform.position, EVPlayer.transform.rotation);
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonController>().enabled = true;
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonInput>().enabled = true;
        GameObject.FindWithTag("Player").GetComponent<vGenericAction>().enabled = true;
        


        yield return new WaitUntil(() => BaseFourthDial.fourthDial);
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 30;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 39;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;

        yield return new WaitUntil(() => BaseFifthDial.fifthDial);
        gameObject.GetComponent<PlayableDirector>().enabled = true;
        yield return new WaitForSeconds(8.7f);
        SceneManager.LoadScene(8);


        yield return null;
    }
}
