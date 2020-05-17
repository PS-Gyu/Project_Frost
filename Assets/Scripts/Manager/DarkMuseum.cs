using Invector.vCharacterController;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using static UnityEngine.Rendering.DebugUI;

public class DarkMuseum : MonoBehaviour
{
    DialogueManager theDM;
    ScanMode sm;
    [SerializeField] VolumeProfile dp;
    [SerializeField] VolumeProfile np;
    [SerializeField] GameObject update;
    [SerializeField] GameObject ladder;
    VolumeProfile pp;

    public bool isInteracted = false;


    // Start is called before the first frame update
    void Start()
    {
        theDM = FindObjectOfType<DialogueManager>();
        sm = FindObjectOfType<ScanMode>();
        StartCoroutine(darkMuseum());
        pp = dp;
    }

    // Update is called once per frame
    void Update()
    {
        sm.p2 = pp;
        if (GameObject.Find("Museum Volume").GetComponent<Volume>().profile == sm.p1) { }
        else
        {
            GameObject.Find("Museum Volume").GetComponent<Volume>().profile = pp;
        }
        isInteracted = USBnteract.isInteracted;
    }

    IEnumerator darkMuseum()
    {
        yield return new WaitForSeconds(2.0f);
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 34;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 34;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;
        pp = np;

        //화면 흔들림
        GameObject.FindWithTag("MainCamera").GetComponent<CameraShake>().m_force = 0.1f;
        yield return new WaitForSeconds(2.0f);
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 35;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 35;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;
        GameObject.FindWithTag("MainCamera").GetComponent<CameraShake>().m_force = 0.0f;


        pp = dp;
        yield return new WaitForSeconds(Random.Range(0.1f, 1.6f));
        pp = np;
        yield return new WaitForSeconds(Random.Range(0.1f, 2.6f));
        pp = dp;
        yield return new WaitForSeconds(Random.Range(0.1f, 1.6f));
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 36;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 58;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());

        pp = np;
        yield return new WaitForSeconds(Random.Range(0.1f, 1.6f));
        pp = dp;
        yield return new WaitForSeconds(Random.Range(0.1f, 1.6f));
        pp = np;
        GameObject.FindWithTag("MainCamera").GetComponent<CameraShake>().m_force = 0.1f;
        yield return new WaitForSeconds(Random.Range(0.1f, 1.6f));
        pp = dp;
        yield return new WaitForSeconds(Random.Range(0.1f, 1.6f));
        pp = np;
        yield return new WaitForSeconds(Random.Range(0.1f, 1.6f));
        pp = dp;
        GameObject.FindWithTag("MainCamera").GetComponent<CameraShake>().m_force = 0.0f;
        yield return new WaitForSeconds(Random.Range(0.1f, 1.6f));
        pp = np;
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;

        GameObject.FindWithTag("USB").GetComponent<MeshRenderer>().enabled = true;
        GameObject.FindWithTag("USB").GetComponent<BoxCollider>().enabled = true;

        yield return new WaitUntil(() => USBnteract.isInteracted);

        //UI애니메이션 실행 + 캐릭터 행동 제한
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 59;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 63;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        update.SetActive(true);
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonInput>().horizontalInput = new GenericInput("", "LeftAnalogHorizontal", "Horizontal");
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonInput>().verticallInput = new GenericInput("", "LeftAnalogVertical", "Vertical");
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonInput>().jumpInput = new GenericInput("", "X", "X");
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonInput>().rollInput = new GenericInput("", "B", "B");
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonInput>().crouchInput = new GenericInput("", "Y", "Y");
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;
        yield return new WaitForSeconds(0.4f);
        pp = dp;
        yield return new WaitForSeconds(0.4f);
        pp = np;
        update.SetActive(false);
        GameObject.FindWithTag("USB").GetComponent<MeshRenderer>().enabled = false;
        GameObject.FindWithTag("USB").GetComponent<BoxCollider>().enabled = false;

        DialogueManager.isRealEnd = false;
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonInput>().horizontalInput = new GenericInput("Horizontal", "LeftAnalogHorizontal", "Horizontal");
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonInput>().verticallInput = new GenericInput("Vertical", "LeftAnalogVertical", "Vertical");
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonInput>().jumpInput = new GenericInput("Space", "X", "X");
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonInput>().rollInput = new GenericInput("Q", "B", "B");
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonInput>().crouchInput = new GenericInput("C", "Y", "Y");

        yield return new WaitForSeconds(Random.Range(0.1f, 1.6f));
        pp = np;
        yield return new WaitForSeconds(Random.Range(0.1f, 1.6f));
        pp = dp;
        yield return new WaitForSeconds(Random.Range(0.1f, 1.6f));
        pp = np;
        yield return new WaitForSeconds(Random.Range(0.1f, 1.6f));
        pp = dp;
        //사다리 애니메이션 및 이후 대화
        ladder.SetActive(true);
        yield return new WaitForSeconds(1.0f);
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 64;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 68;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;



        yield return null;
    }
}
