using Invector.vCamera;
using System.Collections;
using System.Collections.Generic;
using UnityEditorInternal;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.SceneManagement;

public class LightOffMuseum : MonoBehaviour
{
    [SerializeField] GameObject goUI;
    [SerializeField] GameObject pin;
    DialogueManager theDM;
    bool isRespawned = false;
    bool isSaved = false;
    bool isNowGaming = false;
    Vector3 pos;
    // Start is called before the first frame update
    void Start()
    {
        isNowGaming = false;
        isSaved = false;
        DarkMusFirst.firstDial = false;
        DarkMusSec.secDial = false;
        DarkMusThird.thirdDial = false;
        theDM = FindObjectOfType<DialogueManager>();
        StartCoroutine(lightOffMuseum());
    }

    // Update is called once per frame
    void Update()
    {
        if (EnemyAI.isDetected)
        {
            if (isSaved)
            {
                Destroy(pin);
                SceneManager.LoadScene("008_Dark_Museum_2");
            }
            else
            {
                Destroy(pin);
                SceneManager.LoadScene("008_Dark_Museum");
            }
        }
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
            isSaved = true;
            DialogueManager.isMonologue = true;
            gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 20;
            gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 22;
            theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
            yield return new WaitUntil(() => DialogueManager.isRealEnd);
            DialogueManager.isRealEnd = false;

            yield return new WaitUntil(() => DarkMusThird.thirdDial);
            gameObject.GetComponent<PlayableDirector>().enabled = true;

            yield return new WaitForSeconds(21.0f);
            Destroy(pin);
        SceneManager.LoadScene(12);

        yield return null;
    }
}
