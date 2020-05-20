using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Test : MonoBehaviour
{
    [SerializeField] GameObject NowUI;
    [SerializeField] GameObject NextUI;
    Animation nextAnim;

    void Start()
    {
        NowUI.SetActive(false);
        NextUI.SetActive(true);
        nextAnim = NextUI.GetComponent<Animation>();

        nextAnim.Play();
    }
        
    
}
