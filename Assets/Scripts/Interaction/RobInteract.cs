using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RobInteract : MonoBehaviour
{
    public bool robInteracted = false;
    public static bool robisInteracted = false;
    // Start is called before the first frame update
    void Start()
    {
        robisInteracted = false;
    }



    // Update is called once per frame
    void Update()
    {
        robisInteracted = robInteracted;
    }
}
