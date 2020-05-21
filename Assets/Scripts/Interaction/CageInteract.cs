using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CageInteract : MonoBehaviour
{
    public bool cageInteracted = false;
    public static bool cageisInteracted = false;
    // Start is called before the first frame update
    void Start()
    {
        cageisInteracted = false;
    }



    // Update is called once per frame
    void Update()
    {
        cageisInteracted = cageInteracted;
    }
}
