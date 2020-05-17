using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

public class DarkMuseum : MonoBehaviour
{
    DialogueManager theDM;
    ScanMode sm;
    [SerializeField] VolumeProfile dp;
    [SerializeField] VolumeProfile np;
    VolumeProfile pp;

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
        yield return new WaitForSeconds(2.0f);
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 35;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 35;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;


        pp = dp;
        yield return new WaitForSeconds(Random.Range(0.1f, 0.6f));
        pp = np;
        yield return new WaitForSeconds(Random.Range(0.1f, 0.6f));
        pp = dp;
        yield return new WaitForSeconds(Random.Range(0.1f, 0.6f));
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 36;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 58;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());

        pp = np;
        yield return new WaitForSeconds(Random.Range(0.1f, 0.6f));
        pp = dp;
        yield return new WaitForSeconds(Random.Range(0.1f, 0.6f));
        pp = np;
        yield return new WaitForSeconds(Random.Range(0.1f, 0.6f));
        pp = dp;
        yield return new WaitForSeconds(Random.Range(0.1f, 0.6f));
        pp = np;
        yield return new WaitForSeconds(Random.Range(0.1f, 0.6f));
        pp = dp;
        yield return new WaitForSeconds(Random.Range(0.1f, 0.6f));
        pp = np;
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;

        yield return new WaitUntil(() => !USBnteract.isInteracted);
        //UI애니메이션 실행 + 캐릭터 행동 제한

        yield return null;
    }
}
